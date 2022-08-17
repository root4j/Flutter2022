import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void callbackBackgroundWork() async {
  Workmanager().executeTask((taskName, inputData) async {
    // Logica de ejecucion recurrente
    print(DateTime.now());
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicio las tareas en segundo plano
  await Workmanager().initialize(callbackBackgroundWork);

  // Registro la tarea
  await Workmanager().registerPeriodicTask("bg-work-1", "print-date-console",
      frequency: const Duration(minutes: 5));

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
      home: const MyHomePage(title: 'Background Work'),
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
              'Background Work...',
            ),
          ],
        ),
      ),
    );
  }
}
