import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

import 'check_barcode_lack_state.dart';

@injectable
class CheckBarcodeLackController extends BaseCubit<CheckBarcodeLackState> {
  CheckBarcodeLackController(
    this._receivingCardRepository,
  ) : super(CheckBarcodeLackState());

  final ReceivingCardRepository _receivingCardRepository;

  late Barcode? barcode;
  late List<ReceivingCardItem>? scanningBarcode;

  @override
  Future<void> initData() {
    return launch(() async {
      if (barcode != null) {
        await loadBarcode(barcode!.barcode);
      }
    });
  }

  Future<Barcode> loadBarcode(String barcodeString) {
    return launch(() async {
      final barcode = Barcode.fromBarcode(barcodeString);
      
      if (barcode is! LocalBarcode && barcode is! OverseaBarcode) {
        throw ValidationError(type: ValidationErrorType.barcodeNotSupport);
      }

      final scannedBarcodes = await _receivingCardRepository
          .searchReceivingCardDetails(barcode.barcode);

      final barcodes = switch (barcode) {
        LocalBarcode() => List.generate(
            barcode.box ?? 0,
            (index) => barcode.copyWith(unitNo: '${index + 1}'),
          ),
        OverseaBarcode() => List.generate(
            barcode.box ?? 0,
            (index) => barcode.copyWith(unitNo: '${index + 1}'),
          ),
        _ => <Barcode>[],
      };

      scannedBarcodes.addAll(scanningBarcode ?? []);

      emit(
        state.copyWith(
          scannedBarcodes: scannedBarcodes,
          barcodes: barcodes,
        ),
      );
      return barcode;
    });
  }
}
