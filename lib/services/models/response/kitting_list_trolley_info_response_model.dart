import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'kitting_response_model.dart';

part 'kitting_list_trolley_info_response_model.g.dart';

@JsonSerializable()
class KittingListTrolleyInfoResponsesModel extends BaseResponseModel {
  KittingListTrolleyInfoResponsesModel({
    this.trolleyCodeList = const [],
    this.kittingList,
  });

  factory KittingListTrolleyInfoResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$KittingListTrolleyInfoResponsesModelFromJson(json);

  @JsonKey(name: 'codeTrolleys')
  final List<String> trolleyCodeList;

  KittingResponseModel? kittingList;

  @override
  Map<String, dynamic> toJson() => _$KittingListTrolleyInfoResponsesModelToJson(this);
}
