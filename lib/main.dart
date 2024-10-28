import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/camera_service.dart';
import 'services/location_service.dart';
import 'services/photo_service.dart';
import 'viewmodels/camera_viewmodel.dart';
import 'views/camera_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CameraService()),
        Provider(create: (_) => LocationService()),
        Provider(create: (_) => PhotoService()),
        ChangeNotifierProvider(
          create: (context) => CameraViewModel(
            cameraService: context.read<CameraService>(),
            locationService: context.read<LocationService>(),
            photoService: context.read<PhotoService>(),
          ),
        ),
      ],
      child: MaterialApp(home: CameraPage()),
    ),
  );
}
