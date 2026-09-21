import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/repositories/barcode_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'reprint_barcode_ng_state.dart';

@injectable
class ReprintBarcodeNGController extends BaseCubit<ReprintBarcodeNGState> {
  ReprintBarcodeNGController(this._masterRepository, this._barCodeRepository)
      : super(ReprintBarcodeNGState());

  final MasterRepository _masterRepository;
  final BarCodeRepository _barCodeRepository;

  @override
  Future<void> initData() {
    return launch(() async {
      final printerDevices = await _masterRepository.getPrinterDevices();
      final selectedPrinterDevice =
          _masterRepository.getPreviousPrinterDevice();

      emit(
        state.copyWith(
          printerDevices: printerDevices.$2,
          selectedPrinterDevice: selectedPrinterDevice,
        ),
      );
    });
  }

  Future<Barcode> loadBarcode(String barcodeString) {
    return launch(() async {
      final barcode = Barcode.fromBarcode(barcodeString);

      emit(state.copyWith(barcode: barcode));
      updateBarcode();
      return barcode;
    });
  }

  void updateBarcode({
    String? material,
    String? unitNo,
    String? da,
    String? daItem,
    String? po,
    String? poItem,
    int? boxQuantity,
    int? totalQuantity,
    int? box,
    DateTime? deliveryDate,
  }) {
    final barcode = state.barcode;
    if (barcode == null) {
      return;
    }
    final newBarcode = switch (barcode) {
      LocalBarcode() => barcode.copyWith(
          material: material,
          unitNo: unitNo,
          da: da,
          daItem: daItem,
          po: po,
          poItem: poItem,
          boxQuantity: boxQuantity,
          totalQuantity: totalQuantity,
          box: box,
          deliveryDate: deliveryDate,
          useOldUnitNo: false,
        ),
      OverseaBarcode() => barcode.copyWith(
          material: material,
          unitNo: unitNo,
          po: po,
          poItem: poItem,
          boxQuantity: boxQuantity,
          totalQuantity: totalQuantity,
          box: box,
          useOldUnitNo: false,
        ),
      StandardBarcode() => barcode.copyWith(
          material: material,
          po: po,
          poItem: poItem,
          boxQuantity: boxQuantity,
        ),
      PMDBarcode() => barcode.copyWith(
          material: material,
          unitNo: unitNo,
        ),
      SimpleBarcode() => barcode.copyWith(
          material: material,
          boxQuantity: boxQuantity,
          changeGuid: true,
        ),
      Barcode() => null,
    };

    emit(state.copyWith(barcode: newBarcode));
  }

  Future<void> printBarcode(PrinterDevice printerDevice) {
    return launch(() async {
      final barcode = state.barcode;
      if (barcode == null) {
        throw ValidationError(type: ValidationErrorType.barcodeInvalid);
      }

      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      await printer.print(printerDevice, barcode.command);
      await createBarcode(barcode);
    });
  }

  Future<void> createBarcode(Barcode barcode) async {
    await _barCodeRepository.createBarCodeNG(
      material: state.barcode?.material ?? '',
      daInvNo: barcode.deliveryPlan?.no,
      daInvId: barcode.deliveryPlan?.id,
      deliveryDate: barcode.deliveryPlan?.deliveryDate,
      unitNo: barcode.unitNo,
      poNo: barcode.po,
      poItem: barcode.poItem,
      barcode: barcode.barcode,
      totalQuantity: barcode.totalQuantity,
      currentQuantity: barcode.quantity,
      totalBox: barcode.box,
    );
  }
}
