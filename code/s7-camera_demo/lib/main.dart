import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'ui/app.dart';

Future<void> main() async {
  // Asegurar que todos los complementos estén inicializados.
  WidgetsFlutterBinding.ensureInitialized();
  // Obtenga una lista de las cámaras disponibles en el dispositivo.
  final cameras = await availableCameras();
  // Obtenga una cámara específica de la lista de cámaras disponibles.
  final firstCamera = cameras.first;

  // Ejecutar aplicacion con parametro de camara
  runApp(
    MyApp(
      camera: firstCamera,
    ),
  );
}
