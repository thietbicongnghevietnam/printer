enum ScanType {
  scanByBox,
  scanByLot;

  ScanType swap() {
    return switch(this) {
      scanByBox => ScanType.scanByLot,
      scanByLot => ScanType.scanByBox,
    };
  }
}
