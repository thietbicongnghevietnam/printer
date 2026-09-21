enum StorageScanReCardError {
  reCardScanned,
  reCardNullTypeFrequency,
  reCardNullCate,
  importSameTypeFrequency,
  receivingCardInvalid,
  receivingCardExistStorage,
  plsInputSlocQty,
  rcNotFinishedQC,
  outTempRequired,
  inTempRequired,
  quantityNeedBiggerThanZero,
}

enum StockToRcError {
  materialNotSame,
  boxCardScanned,
  doNotHaveVendorInfo,
}
