import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/views/pages/kitting/components/barcode_scanned_state.dart';

@injectable
class BarcodeScannedController extends BaseCubit<BarcodeScannedState> {
  BarcodeScannedController() : super(BarcodeScannedState());

  void loadData(
    List<ReceivingCard>? receivingCards,
    List<ReceivingCardItem>? receivingCardItems,
  ) {
    emit(
      state.copyWith(
        receivingCards: receivingCards,
        receivingCardItems: receivingCardItems,
      ),
    );
  }

  Future<void> updateListReceivingCard(ReceivingCard? receivingCard) {
    return launch(() async {
        final receivingCards = state.receivingCards?.toList().clone();
        receivingCards?.remove(receivingCard);
        emit(state.copyWith(receivingCards: receivingCards));
    });
  }

  Future<void> updateListPartCard(ReceivingCardItem? receivingCardItem) {
    return launch(() async {
      final partCards = state.receivingCardItems?.toList().clone();
      partCards?.remove(receivingCardItem);
      emit(state.copyWith(receivingCardItems: partCards));
    });
  }
}
