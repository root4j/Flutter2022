import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/person.dart';

class PersonController extends GetxController {
  // Variable que maneja el listado de personas
  // que vienen de la base de datos firestore
  final _persons = <Person>[].obs;

  // Variables necesaria para la configuracion de
  // las bases de datos firestore
  final db = FirebaseFirestore.instance.collection('persons');
  final _events = FirebaseFirestore.instance.collection('persons').snapshots();
  late StreamSubscription<Object?> _subs;

  // Getter
  List<Person> get persons => _persons;

  // Metodo para iniciar los listeners y llenar el listado inicialmente
  start() {
    _subs = _events.listen((event) {
      _persons.clear();
      for (var item in event.docs) {
        _persons.add(Person.fromSnapshot(item));
      }
    });
  }

  // Metodo para detener los listeners
  stop() {
    _subs.cancel();
  }

  // Metodo para crear personas
  Future<void> addPerson(Person person) async {
    String? user = FirebaseAuth.instance.currentUser!.email ?? 'user@not.found';
    try {
      db
          .add(person.toJson(user))
          .then((value) => logInfo('Person Created'))
          .catchError((error) => logError('Error $error'));
    } catch (e) {
      return Future.error(e);
    }
  }
}
