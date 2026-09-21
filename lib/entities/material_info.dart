import 'package:smart_warehouse/enums/storage_location.dart';

class MaterialInfo {
  MaterialInfo({
    required this.material,
    this.urgent = false,
    this.samplingCheck = true,
    this.rohsCheck = true,
    this.type,
    this.frequency,
    this.category,
    this.standardPacking,
    this.storageLocation,
  });

  final String material;
  final bool urgent;
  final bool samplingCheck;
  final bool rohsCheck;
  final String? type;
  final String? frequency;
  final String? category;
  final int? standardPacking;
  final StorageLocation? storageLocation;

  bool get isInspection => samplingCheck || rohsCheck;
}
