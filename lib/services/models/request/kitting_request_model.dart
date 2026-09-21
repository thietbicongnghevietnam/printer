import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'kitting_request_model.g.dart';

@JsonSerializable()
 class KittingRequestModel extends BaseRequestModel {
  KittingRequestModel({
      this.plant,
      this.cate,
      this.type,
      this.model,
      this.tab,
      this.proDate,
      this.fromSloc,
      this.sloc,
      this.partNo,
      this.material,
      this.reservation,
      this.kittingDate,
      this.supplyDate,
      this.fromTime,
      this.finishTime,
      this.line,
      this.time,
      this.urgent,
      this.quantity,
      this.status,
      this.date});

  factory KittingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$KittingRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KittingRequestModelToJson(this);

  final String? plant;
  final String? cate;
  final int? type;
  final String? model;
  final int? tab;
  final String? proDate;
  final String? fromSloc;
  final String? sloc;
  final String? partNo;
  final String? material;
  final String? reservation;
  final String? kittingDate;
  final String? supplyDate;
  final String? fromTime;
  final String? finishTime;
  final String? line;
  final String? time;
  final bool? urgent;
  final int? quantity;
  final int? status;
  final String? date;

}
