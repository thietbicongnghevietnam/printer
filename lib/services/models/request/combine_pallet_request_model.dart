import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'combine_pallet_request_model.g.dart';

@JsonSerializable()
class CombinePalletRequestModel extends BaseRequestModel {
  const CombinePalletRequestModel({
    this.temporaryAreaCodeOld,
    required this.temporaryAreaCodeNew,
    required this.receivingCardIds,
  });

  factory CombinePalletRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CombinePalletRequestModelFromJson(json);

  @JsonKey(name: 'temporaryAreaCodeOld')
  final String? temporaryAreaCodeOld;

  @JsonKey(name: 'temporaryAreaCodeNew')
  final String temporaryAreaCodeNew;

  @JsonKey(name: 'receivingCardIds')
  final List<int> receivingCardIds;

  @override
  Map<String, dynamic> toJson() => _$CombinePalletRequestModelToJson(this);
}
