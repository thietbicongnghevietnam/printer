import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'search_pmd_response_model.g.dart';

@JsonSerializable()
class SearchPMDResponsesModel extends BaseResponseModel  {
  SearchPMDResponsesModel({
    required this.quantity,
    required this.barcode,
  });

  factory SearchPMDResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$SearchPMDResponsesModelFromJson(json);

  @JsonKey(name: 'qtyAc')
  final int quantity;
  @JsonKey(name: 'barcodeNo')
  final String barcode;

  @override
  Map<String, dynamic> toJson() => _$SearchPMDResponsesModelToJson(this);
}
