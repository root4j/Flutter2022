import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controllers/my_camera_controller.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final MyCameraController cameraController = Get.find<MyCameraController>();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Iniciar controlador
    cameraController.controller =
        CameraController(cameraController.camera, ResolutionPreset.high);
    // Inicializar el Controller Future
    _initializeControllerFuture = cameraController.controller.initialize();
  }

  @override
  void dispose() {
    cameraController.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          cameraController.initCamera = true;
          return CameraPreview(cameraController.controller);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
