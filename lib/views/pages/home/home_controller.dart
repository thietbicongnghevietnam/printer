import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/enums/role.dart';
import 'package:smart_warehouse/repositories/app_repository.dart';
import 'package:smart_warehouse/repositories/auth_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'home_state.dart';

@injectable
class HomeController extends BaseCubit<HomeState> {
  HomeController(
    this._authRepository,
    this._masterRepository,
    this._appRepository,
  ) : super(HomeState());

  final AuthRepository _authRepository;
  final AppRepository _appRepository;
  final MasterRepository _masterRepository;

  @override
  Future<void> initData() {
    return launch(() async {
      final username = await _authRepository.getUsername();
      _masterRepository.getPrinterDevices();
      _masterRepository.getVendors();
      final roles = await _authRepository.getRoles();
      emit(state.copyWith(userId: username, roles: roles));
    });
  }

  Future<void> checkVersion() {
    return launch(() => _appRepository.checkVersion());
  }

  Future<void> logout() => _authRepository.logout();
}
