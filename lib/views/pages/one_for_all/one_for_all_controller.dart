import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting_card.dart';
import 'package:smart_warehouse/entities/qr_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';

import 'one_for_all_state.dart';

@injectable
class OneForAllController extends BaseCubit<OneForAllState> {
  OneForAllController(this._receivingCardRepository, this._kittingRepository) : super(OneForAllState());

  final ReceivingCardRepository _receivingCardRepository;
  final KittingRepository _kittingRepository;

  @override
  Future<void> initData() {
    return launch(() async {

    });
  }

  Future<void> scanCard(String barcode) {
    return launch(() async {
      var qrCard = QRCard(barcode: barcode);
      if (ReceivingCard.validate(barcode)) {
        final id = ReceivingCard.getReceivingCardID(barcode);
        qrCard = await _receivingCardRepository.getReceivingCard(id);
      } else if (KittingCard.validate(barcode)) {
        final id = KittingCard.getKittingCardID(barcode);
        qrCard = await _kittingRepository.getKittingCard(id);
      } else if(Barcode.validate(barcode)) {
        qrCard = Barcode.fromBarcode(barcode);
        final list = await _receivingCardRepository.searchReceivingCardDetails(barcode);
        if (list.length == 1) {
          qrCard.as<Barcode>()?.quantity = list.single.currentQuantity;
        }
      }
      emit(state.copyWith(qrCard: qrCard));
    });
  }
}
