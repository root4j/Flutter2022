import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_camera_controller.dart';

class PreviewWidget extends StatefulWidget {
  const PreviewWidget({Key? key}) : super(key: key);

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  final MyCameraController cameraController = Get.find<MyCameraController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        if (cameraController.path.isNotEmpty) {
          return Image.file(File(cameraController.path));
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
