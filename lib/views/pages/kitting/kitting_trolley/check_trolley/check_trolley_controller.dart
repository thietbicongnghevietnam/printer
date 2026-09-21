import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_trolley/check_trolley/check_trolley_state.dart';

@injectable
class CheckTrolleyController extends BaseCubit<CheckTrolleyState> {
  CheckTrolleyController() : super(CheckTrolleyState());
}
