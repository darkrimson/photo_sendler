import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../services/camera_service.dart';
import '../services/location_service.dart';
import '../services/photo_service.dart';

class CameraViewModel extends ChangeNotifier {
  final CameraService cameraService;
  final LocationService locationService;
  final PhotoService photoService;
  String comment = '';
  bool isLoading = false;

  CameraViewModel({
    required this.cameraService,
    required this.locationService,
    required this.photoService,
  });

  void updateComment(String newComment) {
    comment = newComment;
    notifyListeners();
  }

  Future<void> captureAndSendPhoto() async {
    final photo = await cameraService.takePicture();
    final location = await locationService.getLocation();

    if (photo != null && location != null) {
      final photoModel = PhotoModel(
        comment: comment,
        latitude: location.latitude!,
        longitude: location.longitude!,
        photoPath: photo.path,
      );

      await photoService.sendPhoto(photoModel);
    }
  }
}
