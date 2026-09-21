import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';

@singleton
class CameraManager {
  late List<CameraDescription> cameras;

  Future<void> initCamera() async {
    cameras = await availableCameras();
  }
}