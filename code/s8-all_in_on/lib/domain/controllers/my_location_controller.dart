import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/my_location.dart';

class MyLocationController extends GetxController {
  // Variable que maneja el listado de personas
  // que vienen de la base de datos firestore
  final _locations = <MyLocation>[].obs;

  // Variables necesaria para la configuracion de
  // las bases de datos firestore
  final db = FirebaseFirestore.instance.collection('locations');
  final _events =
      FirebaseFirestore.instance.collection('locations').snapshots();
  late StreamSubscription<Object?> _subs;

  // Getter
  List<MyLocation> get locations => _locations;

  // Metodo para iniciar los listeners y llenar el listado inicialmente
  start() {
    _subs = _events.listen((event) {
      _locations.clear();
      for (var item in event.docs) {
        _locations.add(MyLocation.fromSnapshot(item));
      }
    });
  }

  // Metodo para detener los listeners
  stop() {
    _subs.cancel();
  }

  // Metodo para crear objetos
  Future<void> addLocation(MyLocation location) async {
    try {
      db
          .add(location.toJson())
          .then((value) => logInfo('Location Created'))
          .catchError((error) => logError('Error $error'));
    } catch (e) {
      return Future.error(e);
    }
  }
}
