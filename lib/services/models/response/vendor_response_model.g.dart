// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorResponseModel _$VendorResponseModelFromJson(Map<String, dynamic> json) =>
    VendorResponseModel(
      vendorCode: json['vendorCode'] as String?,
      globalCode: json['globalCode'] as String?,
      vendorName: json['vendorName'] as String?,
      vendorNameShort: json['vendorNameShort'] as String?,
      country: json['country'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] as String?,
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$VendorResponseModelToJson(
        VendorResponseModel instance) =>
    <String, dynamic>{
      'vendorCode': instance.vendorCode,
      'globalCode': instance.globalCode,
      'vendorName': instance.vendorName,
      'vendorNameShort': instance.vendorNameShort,
      'country': instance.country,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'updatedBy': instance.updatedBy,
    };
