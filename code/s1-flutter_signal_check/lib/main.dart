import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
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
      home: const MyHomePage(title: 'Check Signal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Cuando se trabaja con futuros es importante que los
// metodos sean asincronos y utilizar el await al
// momento de invocar los futuros
class _MyHomePageState extends State<MyHomePage> {
  // Variable donde se guarda el tipo de red
  String _signal = "";

  // Retornar futuro de tipo de señal en ese instante
  Future<ConnectivityResult> _getSignalType() {
    return (Connectivity().checkConnectivity());
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
          children: <Widget>[
            // Tipo de red al momento de presionar el boton
            Text(
              _signal,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Verfivar tipo de señal
          var connectivityResult = await _getSignalType();
          setState(() {
            // Validar si es Wifi
            if (connectivityResult == ConnectivityResult.wifi) {
              _signal = "Wifi";
              // Validar si es Movil
            } else if (connectivityResult == ConnectivityResult.mobile) {
              _signal = "Mobile";
            } else {
              // No hay señal
              _signal = "No Signal";
            }
          });
        },
        tooltip: 'Check',
        child: const Icon(Icons.wifi_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
