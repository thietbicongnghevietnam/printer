import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/app_repository.dart';
import 'package:smart_warehouse/repositories/auth_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/views/pages/login/login_state.dart';

@injectable
class LoginController extends BaseCubit<LoginState> {
  LoginController(
    this._authRepository,
    this._appRepository,
  ) : super(LoginState());

  final AuthRepository _authRepository;
  final AppRepository _appRepository;

  @override
  Future<void> initData() async {
    return launch(() async {
      await checkVersion();
      emit(state.copyWith(pageStatus: PageStatus.loaded));
    });
  }

  Future<void> checkVersion() {
    return launch(() async {
      final version = await _appRepository.getVersion();
      final serverVersion = await _appRepository.checkVersion();
      emit(
        state.copyWith(
          version: version,
          newVersion: true,
          // newVersion: serverVersion != version && serverVersion != null,
        ),
      );
    });
  }

  Future<bool> login(String id) async {
    return launch(() => _authRepository.login(id));
  }
}
