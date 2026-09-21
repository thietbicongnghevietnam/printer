class KittingRequest {
  KittingRequest({
    this.rcDetailIDs,
    this.rciDs,
    this.kittingListDetailId,
    this.quantity,
  });

  final List<(int, int)>? rcDetailIDs;
  final List<(int, int)>? rciDs;
  final int? kittingListDetailId;
  final double? quantity;
}
