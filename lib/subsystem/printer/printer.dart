class PrinterDevice {
  PrinterDevice({required this.id, required this.macAddress});

  final String id;
  final String macAddress;
}

abstract class Printer {
  Future<void> connect(PrinterDevice device);

  Future<void> print(PrinterDevice device, String data);

  Future<void> disconnect();

  Future<void> multiPrint(PrinterDevice device, List<String> listData);
}
