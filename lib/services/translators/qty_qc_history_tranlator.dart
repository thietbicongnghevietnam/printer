import 'package:smart_warehouse/entities/storing/qty_qc_history.dart';
import 'package:smart_warehouse/services/models/response/qty_qc_history_response_model.dart';

extension QtyQCHistoryTranslator on QtyQCHistoryResponseModel {
  QtyQCHistory toEntity() {
    return QtyQCHistory(
      material: material,
      barcodeBox: barcodeBox,
      barcode: barcode,
      plant: plant,
      sloc: sloc,
      qtyBox: qtyBox,
      qtyRC: qtyRC,
    );
  }
}
