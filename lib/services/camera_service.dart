import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller?.initialize();
  }

  Future<XFile?> takePicture() async {
    if (controller != null && controller!.value.isInitialized) {
      return await controller!.takePicture();
    }
    return null;
  }

  void dispose() {
    controller?.dispose();
  }
}
