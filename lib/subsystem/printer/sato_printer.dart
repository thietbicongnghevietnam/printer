import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

@Singleton(as: Printer)
class SatoPrinter extends Printer {
  late BluetoothConnection bluetoothConnection;

  @override
  Future<void> connect(PrinterDevice device) async {
    try {
      bluetoothConnection =
          await BluetoothConnection.toAddress(device.macAddress);
      if (!bluetoothConnection.isConnected) {
        throw ValidationError(type: ValidationErrorType.connectPrinterError);
      }
    } catch (e) {
      throw ValidationError(type: ValidationErrorType.connectPrinterError);
    }
  }

  @override
  Future<void> disconnect() async {
    bluetoothConnection.close();
  }

  @override
  Future<void> print(PrinterDevice device, String data) async {
    try {
      final ENQ = Uint8List.fromList([5]);
      final ACK = Uint8List.fromList([6]);
      if (bluetoothConnection.isConnected) {
        final command = Uint8List.fromList(data.codeUnits);
        bluetoothConnection.output.add(command);
        bluetoothConnection.output.allSent;
        bluetoothConnection.input?.listen((event) async {
          if (event[0] == ACK[0]) {
            try {
              bluetoothConnection.output.add(ENQ);
              await bluetoothConnection.output.allSent;
              getIt<StorageManager>().set(
                StorageKeys.printer,
                device.macAddress,
              );
            } catch (e) {
              bluetoothConnection.close();
            }
          } else {
            bluetoothConnection.close();
          }
        });
      } else {
        throw ValidationError(type: ValidationErrorType.printError);
      }
    } catch (e) {
      if (e is ErrorEntity) {
        rethrow;
      } else {
        throw ValidationError(type: ValidationErrorType.printError);
      }
    }
  }

  @override
  Future<void> multiPrint(PrinterDevice device, List<String> listData) async {
    try {
      final ENQ = Uint8List.fromList([5]);
      final ACK = Uint8List.fromList([6]);
      if (bluetoothConnection.isConnected) {
          if (listData.isNotEmpty) {
            final byteData = convertListStringToUint8List(listData);
            bluetoothConnection.output.add(byteData);
            bluetoothConnection.output.allSent;
            bluetoothConnection.input?.listen((event) async {
              if (event[0] == ACK[0]) {
                try {
                  bluetoothConnection.output.add(ENQ);
                  bluetoothConnection.output.allSent;
                  getIt<StorageManager>().set(
                    StorageKeys.printer,
                    device.macAddress,
                  );
                } catch (e) {
                  bluetoothConnection.close();
                }
              } else {
                bluetoothConnection.close();
              }
            });
          }
      } else {
        throw ValidationError(type: ValidationErrorType.printError);
      }
    } catch (e) {
      if (e is ErrorEntity) {
        rethrow;
      } else {
        throw ValidationError(type: ValidationErrorType.printError);
      }
    }
  }

  Uint8List convertListStringToUint8List(List<String> listData) {
    final bytes = <int>[];
    for (final value in listData) {
      bytes.addAll(value.codeUnits);
    }
    return Uint8List.fromList(bytes);
  }
}
