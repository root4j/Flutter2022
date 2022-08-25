import 'package:camera_demo/ui/widgets/camera_widget.dart';
import 'package:camera_demo/ui/widgets/preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_camera_controller.dart';

class HomePage extends StatelessWidget {
  final _index = 0.obs;

  HomePage({Key? key}) : super(key: key);

  Widget _getScreen(int index) {
    if (index == 0) {
      return const CameraWidget();
    } else {
      return const PreviewWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyCameraController cameraController = Get.find<MyCameraController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Demo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Obx(() => _getScreen(_index.value)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          // Verificar si la camara ha sido iniciada
          if (cameraController.initCamera) {
            try {
              // Tomar foto
              final image = await cameraController.controller.takePicture();
              // Asignar path a nuestro controlador
              cameraController.path = image.path;
              // Cambiar a previsualizar
              _index.value = 1;
            } catch (e) {
              print(e);
            }
          }
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_rounded),
              label: 'Cámara',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: 'Ver',
            ),
          ],
          currentIndex: _index.value,
          onTap: (index) {
            _index.value = index;
          },
        );
      }),
    );
  }
}
