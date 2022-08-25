import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/model/my_location.dart';
import '../../domain/controllers/geo_controller.dart';
import '../../domain/controllers/my_location_controller.dart';

class MyLocationViewWidget extends StatefulWidget {
  const MyLocationViewWidget({Key? key}) : super(key: key);

  @override
  State<MyLocationViewWidget> createState() => _MyLocationViewWidgetState();
}

class _MyLocationViewWidgetState extends State<MyLocationViewWidget> {
  // Controladores Get
  GeoController geoCtrl = Get.find();
  MyLocationController myCtrl = Get.find();
  // Controladores Widgets
  final ScrollController _scrollCtrl = ScrollController();

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

  // Widget encargado de mostrar los objetos que se encuentren
  // registrados en la base de datos
  Widget _locationCard(MyLocation location, int index) {
    var latitude = location.latitude;
    var longitude = location.longitude;
    var altitude = location.altitude;
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          final url = "https://www.google.com/maps?q=$latitude,$longitude";
          await launchUrlString(url);
        },
        child: ListTile(
          title: Text(
            DateFormat('yyyy-MM-dd HH:mm')
                .format(location.activityDate.toDate()),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
              'Latitude: $latitude | Longitude: $longitude | Altitude: $altitude'),
        ),
      ),
    );
  }

  // Widget encargado de mostrar el listado de objetos en la
  // base de datos
  Widget _locationList() {
    _getPosition();
    return GetX<MyLocationController>(
      builder: ((controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        // Ordenamiento
        myCtrl.locations
            .sort(((a, b) => a.activityDate.compareTo(b.activityDate)));
        return ListView.builder(
          itemCount: myCtrl.locations.length,
          controller: _scrollCtrl,
          itemBuilder: ((context, index) {
            var loc = myCtrl.locations[index];
            return _locationCard(loc, index);
          }),
        );
      }),
    );
  }

  // Hacer scroll de los mensajes nuevos
  _scrollToEnd() async {
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _locationList(),
        ),
      ],
    );
  }
}
