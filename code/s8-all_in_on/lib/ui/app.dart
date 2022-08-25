import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/controllers/authentication_controller.dart';
import '../domain/controllers/geo_controller.dart';
import '../domain/controllers/message_controller.dart';
import '../domain/controllers/my_camera_controller.dart';
import '../domain/controllers/my_location_controller.dart';
import '../domain/controllers/person_controller.dart';
import 'firebase_central.dart';

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
    // Inyectar los controladores en el proyecto
    Get.put(AuthenticationController());
    Get.put(GeoController());
    Get.put(MessageController());
    Get.put(MyLocationController());
    Get.put(PersonController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebaseCentral(),
    );
  }
}
