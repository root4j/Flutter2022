import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notification'),
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
  // Declarar clase notificadora
  late FlutterLocalNotificationsPlugin _fnp;
  late FlutterLocalNotificationsPlugin _fnpFail;

  // Sobreescribir un metodo de la clase State
  @override
  void initState() {
    // Invocar la funcionalidad normal
    super.initState();
    // Logica complementaria
    var ais = const AndroidInitializationSettings('face_icon');
    var ais_fail = const AndroidInitializationSettings('angry_face_icon');
    var iis = const IOSInitializationSettings();
    var iss = InitializationSettings(android: ais, iOS: iis);
    var iss_fail = InitializationSettings(android: ais_fail, iOS: iis);
    _fnp = FlutterLocalNotificationsPlugin();
    _fnp.initialize(iss, onSelectNotification: onSelectNotification);
    _fnpFail = FlutterLocalNotificationsPlugin();
    _fnpFail.initialize(iss_fail, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Notification",
        ),
        content: Text(payload!),
      ),
    );
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
              'App Notification Sample',
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showNotification(true);
            },
            tooltip: 'Notify',
            child: const Icon(Icons.message_rounded),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: () {
              showNotification(false);
            },
            tooltip: 'Notify Error',
            child: const Icon(Icons.messenger_sharp),
          ),
        ],
      ),
    );
  }

  Future showNotification(bool type) async {
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
    // Mostrar la notificacion
    if (type) {
      _fnp.show(Random().nextInt(16), "Notification Success",
          "Message of Success!", nd,
          payload: "Message of Success!");
    } else {
      _fnpFail.show(
          Random().nextInt(16), "Notification Fail", "Message of Fail!", nd,
          payload: "Message of Fail!");
    }
  }
}
