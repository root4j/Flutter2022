import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import 'ui/app.dart';

void main() async {
  // Esto es obligatorio
  WidgetsFlutterBinding.ensureInitialized();

  // Asegurar que todos los complementos estén inicializados.
  WidgetsFlutterBinding.ensureInitialized();
  // Obtenga una lista de las cámaras disponibles en el dispositivo.
  final cameras = await availableCameras();
  // Obtenga una cámara específica de la lista de cámaras disponibles.
  final firstCamera = cameras.first;

  // Iniciar instancia de Loggy
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
    showColors: true,
  ));

  // Iniciar Firebase
  await Firebase.initializeApp();

  runApp(
    MyApp(
      camera: firstCamera,
    ),
  );
}
