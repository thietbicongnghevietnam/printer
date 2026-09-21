import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/services/models/response/plant_category_response_model.dart';

extension PlantSlocCategoryTranslator on PlantCategoryResponseModel {
  PlantCategory toEntity() {
    return PlantCategory(
      plant: plant,
    );
  }
}
