import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/translators/material_info_translator.dart';

@injectable
class MaterialRepository {
  MaterialRepository(this._apiService);

  final ApiService _apiService;

  Future<MaterialInfo?> getMaterialInfo({
    required String material,
    required String plant,
    required String sloc,
    required String? vendorCode,
  }) async {
    final response =
        await _apiService.getMaterialInfo(material, plant, sloc, vendorCode);
    return response?.toEntity() ?? MaterialInfo(material: material);
  }
}
