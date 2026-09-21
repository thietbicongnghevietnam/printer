import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/enums/storage_location.dart';
import 'package:smart_warehouse/services/models/response/material_info_response_model.dart';

extension MaterialInfoExtension on MaterialInfoResponseModel {
  MaterialInfo toEntity() {
    return MaterialInfo(
      material: material,
      urgent: urgent?.isNotEmpty ?? false,
      samplingCheck: samplingCheck == 1,
      rohsCheck: rohsCheck == 1,
      type: type,
      frequency: frequency,
      standardPacking: qtyStandardPacking,
      storageLocation: StorageLocation.fromCode(typeSloc),
      category: category,
    );
  }
}
