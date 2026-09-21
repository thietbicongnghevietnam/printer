import 'package:smart_warehouse/entities/kitting_request.dart';
import 'package:smart_warehouse/services/models/request/kitting_card_request_model.dart';

extension KittingCardRequestTranSlator on KittingRequest {
  KittingCardRequestModel toRequestModel() {
    return KittingCardRequestModel(
      rcDetailIDs: rcDetailIDs?.map((e) => KittingCardRequestItemModel(id: e.$1, index: e.$2)).toList(),
      rciDs: rciDs?.map((e) => KittingCardRequestItemModel(id: e.$1, index: e.$2)).toList(),
      kittingListDetailId: kittingListDetailId,
      quantity: quantity,
    );
  }
}
