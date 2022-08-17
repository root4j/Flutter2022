import 'package:flutter/material.dart';
import 'package:flutter_signal_check_get/controllers/signal_controller.dart';
import 'package:get/get.dart';

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
      home: const MyHomePage(title: 'Check Signal Get'),
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
  // Obtener instancia de mi controlador
  SignalController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Text(
                ctrl.signal,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Obx(
              () => Icon(ctrl.icon, size: 45),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctrl.checkSignalType();
        },
        tooltip: 'Check',
        child: const Icon(Icons.wifi_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
