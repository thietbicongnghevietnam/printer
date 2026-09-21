import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'out_pallet_request_model.g.dart';

@JsonSerializable()
class OutPalletRequestModel extends BaseRequestModel {
  const OutPalletRequestModel({
    this.temporaryAreaCode,
  });

  factory OutPalletRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OutPalletRequestModelFromJson(json);

  @JsonKey(name: 'temporaryAreaCode')
  final String? temporaryAreaCode;

  @override
  Map<String, dynamic> toJson() => _$OutPalletRequestModelToJson(this);
}
