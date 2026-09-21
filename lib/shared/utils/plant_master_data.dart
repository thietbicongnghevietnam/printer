import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';

@singleton
class PlantMasterData {
  late List<PlantTypeFrequencyResponseModel> plantDataForSloc;

  Future<void> initPlantCateSloc() async {
  }

  Future<void> initPlantSlocCate() async {
  }
}