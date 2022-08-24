import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

import 'ui/app.dart';

void main() async {
  // Esto es obligatorio
  WidgetsFlutterBinding.ensureInitialized();

  // Iniciar instancia de Loggy
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(
    showColors: true,
  ));

  // Iniciar Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}
