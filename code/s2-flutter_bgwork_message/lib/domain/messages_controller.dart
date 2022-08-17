import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagesController extends GetxController {
  final List<String> messages = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras viverra placerat sapien. Aenean egestas sagittis nulla.",
    "Nunc ultricies pretium luctus. Integer commodo, turpis id hendrerit maximus, nibh metus iaculis ligula, sit amet hendrerit velit nisi et est.",
    "Suspendisse potenti. Donec dictum nulla sit amet nibh semper tempus. Proin fringilla urna lectus, vel posuere enim scelerisque eu.",
    "Curabitur urna ligula, congue eget felis sed, ultricies pretium lacus. Phasellus ut aliquet magna, fermentum elementum ex. Etiam a fringilla orci.",
    "Curabitur auctor egestas volutpat. Duis vel sem vitae dui dignissim ullamcorper. Nulla facilisi.",
    "Donec viverra sapien eu nisi molestie, vel convallis neque facilisis. Quisque ante tortor, tempor at tincidunt in, porttitor vitae neque.",
    "Etiam dictum, diam a tincidunt bibendum, mauris elit gravida erat, a tincidunt orci enim a est. Maecenas facilisis odio velit, quis auctor velit posuere suscipit."
  ];

  // Declarar clase notificadora
  late FlutterLocalNotificationsPlugin _fnp;

  MessagesController() {
    var ais = const AndroidInitializationSettings('happy_icon');
    var iis = const IOSInitializationSettings();
    var iss = InitializationSettings(android: ais, iOS: iis);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss);
  }

  Future showNotification() async {
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
    var body = messages[Random().nextInt(7)];
    var title = DateFormat("yyyy-MM-dd kk:mm").format(DateTime.now());
    // Mostrar la notificacion
    _fnp.show(Random().nextInt(16), title, body, nd);
  }
}
