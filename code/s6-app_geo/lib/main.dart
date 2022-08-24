import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controllers/geo_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Iniciar instancia de Loggy
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(GeoController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Geo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GeoController ctrl = Get.find();

  void _openSettings() async {
    var status = await ctrl.getStatusGpsPermission();
    if (status.isPermanentlyDenied || status.isDenied) {
      openAppSettings();
    }
  }

  void _getPosition() async {
    try {
      var status = await ctrl.getStatusGpsPermission();
      if (!status.isGranted) {
        status = await ctrl.requestGpsPermission();
      }
      if (status.isGranted) {
        var pst = await ctrl.getCurrentPosition();
        var latitude = pst.latitude;
        var longitude = pst.longitude;
        Get.snackbar(
          'Position',
          'Latitud: $latitude | Longitud: $longitude',
          icon: const Icon(
            Icons.gps_fixed,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          'Position',
          'No GPS Found',
          icon: const Icon(
            Icons.gps_off,
            color: Colors.red,
          ),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'App for GeoPosition!!!',
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _openSettings,
              tooltip: 'Settings',
              child: const Icon(Icons.settings),
            ),
            const SizedBox(
              height: 4,
            ),
            FloatingActionButton(
              onPressed: _getPosition,
              tooltip: 'Position',
              child: const Icon(Icons.gps_fixed),
            ),
          ],
        ));
  }
}
