import 'package:smart_warehouse/entities/fifo.dart';
import 'package:smart_warehouse/entities/inventory.dart';
import 'package:smart_warehouse/services/models/response/fifo_response_model.dart';

extension FifoTranslator on FifoResponseModel {
  Fifo toEntity() {
    return Fifo(id: id, barcode: barcode);
  }
}
