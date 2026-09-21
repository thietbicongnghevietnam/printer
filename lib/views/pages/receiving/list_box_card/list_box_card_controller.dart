import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';

import 'list_box_card_state.dart';

@injectable
class ListBoxCardController extends BaseCubit<ListBoxCardState> {
  ListBoxCardController() : super(ListBoxCardState());
}
