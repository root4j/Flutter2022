import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/message.dart';

class MessageController extends GetxController {
  // Constantes
  final String dbName = "messages";
  // Variable que maneja el listado de mensajes
  // que vienen de la base de datos en tiempo real
  var messages = <Message>[].obs;

  // Variables necesaria para la configuracion de
  // las bases de datos en tiempo real
  final db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> newData;
  late StreamSubscription<DatabaseEvent> updateData;

  // Metodo para iniciar los listeners
  start() {
    messages.clear();
    newData = db.child(dbName).onChildAdded.listen(_onAddData);
    updateData = db.child(dbName).onChildChanged.listen(_onUpdateData);
  }

  // Metodo para detener los listeners
  stop() {
    newData.cancel();
    updateData.cancel();
  }

  // Metodo que escucha los nuevos registros
  _onAddData(DatabaseEvent event) {
    logInfo('Data was Add...');
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    messages.add(Message.fromJson(event.snapshot, json));
  }

  // Metodo que escucha las actualizaciones de registros
  _onUpdateData(DatabaseEvent event) {
    logInfo('Data was Updated...');
    var oldData = messages.singleWhere((element) {
      return element.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    messages[messages.indexOf(oldData)] =
        Message.fromJson(event.snapshot, json);
  }

  // Metodo para agregar mensajes
  Future<void> addMessage(Message msg) async {
    logInfo('New Message...');
    try {
      db.child(dbName).push().set(msg.toJson());
    } catch (e) {
      logError('Error Add: $e');
      return Future.error(e);
    }
  }

  // Metodo para actualizar mensajes
  Future<void> updateMessage(Message msg) async {
    logInfo('Update Message... $msg.key');
    try {
      db.child(dbName).child(msg.key!).set(msg.toJson());
    } catch (e) {
      logError('Error Update: $e');
      return Future.error(e);
    }
  }

  // Metodo para eliminar mensajes
  Future<void> deleteMessage(Message msg, int index) async {
    logInfo('Delete Message... $msg.key');
    try {
      db
          .child(dbName)
          .child(msg.key!)
          .remove()
          .then((value) => messages.removeAt(index));
    } catch (e) {
      logError('Error Delete: $e');
      return Future.error(e);
    }
  }
}
