import 'dart:math';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagesController extends GetxController {
  // Declarar clase notificadora
  late FlutterLocalNotificationsPlugin _fnp;

  MessagesController() {
    var ais = const AndroidInitializationSettings('happy_icon');
    var iis = const IOSInitializationSettings();
    var iss = InitializationSettings(android: ais, iOS: iis);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss);
  }

  Future showNotification(String message) async {
    // Crear detalles para Android
    var ands = const AndroidNotificationDetails("channel-Id-1", "channel-name",
        channelDescription: "Test Class",
        playSound: false,
        importance: Importance.high,
        priority: Priority.max);
    // Crear detalles para iOS
    var inds = const IOSNotificationDetails(presentSound: false);
    // Unificar configuraciones de detalle
    var nd = NotificationDetails(android: ands, iOS: inds);
    // Seleccionar nuestro mensaje
    var title = DateFormat("yyyy-MM-dd kk:mm").format(DateTime.now());
    // Mostrar la notificacion
    _fnp.show(Random().nextInt(16), title, message, nd);
  }
}
