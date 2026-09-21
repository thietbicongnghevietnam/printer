import 'package:smart_warehouse/services/models/response/printer_device_response_model.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

extension PrinterDeviceTranslator on PrinterDeviceResponseModel {
  PrinterDevice toEntity() {
    return PrinterDevice(id: id, macAddress: macAddress);
  }
}