import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/controllers/authentication_controller.dart';
import '../domain/controllers/message_controller.dart';
import 'firebase_central.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inyectar los controladores en el proyecto
    Get.put(AuthenticationController());
    Get.put(MessageController());

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
