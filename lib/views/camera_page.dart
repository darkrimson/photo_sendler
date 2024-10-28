import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/camera_viewmodel.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CameraViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Camera App')),
      body: Column(
        children: [
          FutureBuilder(
            future: viewModel.cameraService.initializeCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio:
                      viewModel.cameraService.controller!.value.aspectRatio,
                  child: AspectRatio(
                    aspectRatio:
                        viewModel.cameraService.controller!.value.aspectRatio,
                    child: CameraPreview(viewModel.cameraService.controller!),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: viewModel.updateComment,
              decoration: const InputDecoration(hintText: 'Enter comment'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.captureAndSendPhoto,
            child: const Text('Capture and Send Photo'),
          ),
        ],
      ),
    );
  }
}
