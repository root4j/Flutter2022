import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/geo_controller.dart';
import '../controllers/my_location_controller.dart';
import '../models/my_location.dart';
import 'my_location_view_widget.dart';

class AppCentralPage extends StatefulWidget {
  const AppCentralPage({Key? key}) : super(key: key);

  @override
  State<AppCentralPage> createState() => _AppCentralPageState();
}

class _AppCentralPageState extends State<AppCentralPage> {
  GeoController geoCtrl = Get.find();
  MyLocationController myCtrl = Get.find();

  // Metodo para iniciar la instancia de los listeners
  @override
  void initState() {
    super.initState();
    myCtrl.start();
  }

  // Metodo para detener la instancia de los listeners
  @override
  void dispose() {
    myCtrl.stop();
    super.dispose();
  }

  void _openSettings() async {
    var status = await geoCtrl.getStatusGpsPermission();
    if (status.isPermanentlyDenied || status.isDenied) {
      openAppSettings();
    }
  }

  void _getPosition() async {
    try {
      var status = await geoCtrl.getStatusGpsPermission();
      if (!status.isGranted) {
        status = await geoCtrl.requestGpsPermission();
      }
      if (status.isGranted) {
        var pst = await geoCtrl.getCurrentPosition();
        var loc = MyLocation(pst.latitude, pst.longitude, pst.altitude);
        myCtrl.addLocation(loc);
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
        title: const Text("Flutter My Location"),
      ),
      body: const MyLocationViewWidget(),
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
      ),
    );
  }
}
