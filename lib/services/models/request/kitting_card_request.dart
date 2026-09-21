import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';
import 'package:smart_warehouse/services/models/request/kitting_card_request_model.dart';

part 'kitting_card_request.g.dart';

@JsonSerializable()
class KittingCardRequest extends BaseRequestModel {
  KittingCardRequest( {
     this.kittingCardsRequests,
     this.isPreview,
    this.material,
    this.isSub,
  });

  factory KittingCardRequest.fromJson(Map<String, dynamic> json) =>
      _$KittingCardRequestFromJson(json);

  final List<KittingCardRequestModel>? kittingCardsRequests;
  final bool? isPreview;
  final String? material;
  final bool? isSub;

  @override
  Map<String, dynamic> toJson() => _$KittingCardRequestToJson(this);
}
