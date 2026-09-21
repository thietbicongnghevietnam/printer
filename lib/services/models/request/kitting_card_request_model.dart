import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'kitting_card_request_model.g.dart';

@JsonSerializable()
class KittingCardRequestItemModel extends BaseRequestModel {
  KittingCardRequestItemModel({
    required this.index,
    required this.id,
  });

  factory KittingCardRequestItemModel.fromJson(Map<String, dynamic> json) =>
      _$KittingCardRequestItemModelFromJson(json);

  final int id;
  final int index;

  @override
  Map<String, dynamic> toJson() => _$KittingCardRequestItemModelToJson(this);
}

@JsonSerializable()
class KittingCardRequestModel extends BaseRequestModel {
  KittingCardRequestModel({
    this.rcDetailIDs,
    this.rciDs,
    this.kittingListDetailId,
    this.quantity,
  });

  factory KittingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$KittingCardRequestModelFromJson(json);

  final List<KittingCardRequestItemModel>? rcDetailIDs;
  final List<KittingCardRequestItemModel>? rciDs;
  final int? kittingListDetailId;
  final double? quantity;

  @override
  Map<String, dynamic> toJson() => _$KittingCardRequestModelToJson(this);
}
