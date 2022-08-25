import 'package:camera/camera.dart';
import 'package:camera_demo/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_camera_controller.dart';

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Controlador Get
  late final MyCameraController cameraController;

  @override
  void initState() {
    cameraController = Get.put(MyCameraController(widget.camera));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
