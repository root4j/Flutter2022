import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/my_location_controller.dart';
import '../models/my_location.dart';

class MyLocationViewWidget extends StatefulWidget {
  const MyLocationViewWidget({Key? key}) : super(key: key);

  @override
  State<MyLocationViewWidget> createState() => _MyLocationViewWidgetState();
}

class _MyLocationViewWidgetState extends State<MyLocationViewWidget> {
  // Controladores Get
  MyLocationController ctrl = Get.find();
  // Controladores Widgets
  final ScrollController _scrollCtrl = ScrollController();

  // Metodo para iniciar la instancia de los listeners
  @override
  void initState() {
    super.initState();
    ctrl.start();
  }

  // Metodo para detener la instancia de los listeners
  @override
  void dispose() {
    ctrl.stop();
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
    return GetX<MyLocationController>(
      builder: ((controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        // Ordenamiento
        ctrl.locations
            .sort(((a, b) => a.activityDate.compareTo(b.activityDate)));
        return ListView.builder(
          itemCount: ctrl.locations.length,
          controller: _scrollCtrl,
          itemBuilder: ((context, index) {
            var loc = ctrl.locations[index];
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
