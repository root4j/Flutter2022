// Libreria para manejar la autenticacion con firebase
import 'package:firebase_auth/firebase_auth.dart';
// Libreria que me permite trabajar con firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Asegurar que los widgets principales se inicien
  WidgetsFlutterBinding.ensureInitialized();
  // Iniciar la instancia de Firebase
  await Firebase.initializeApp();
  // Ejecutar aplicacion
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final String _user = "rjay@uninorte.edu.co";
  final String _pswd = "Tempo123!";
  String message = "";

  void _createUser() async {
    var msg = 'User created!';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _user, password: _pswd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = 'The password is too weak!';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The email is already in use!';
      }
    } catch (e) {
      msg = 'Exception error: $e';
    }
    setState(() {
      message = msg;
    });
  }

  void _singInUser() async {
    var msg = 'User authenticated!';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _user, password: _pswd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'User not found!';
      } else if (e.code == 'wrong-password') {
        msg = 'Worng password';
      }
    } catch (e) {
      msg = 'Exception error: $e';
    }
    setState(() {
      message = msg;
    });
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
            Text(
              message,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _createUser,
            tooltip: 'Create',
            child: const Icon(Icons.supervised_user_circle),
          ),
          const SizedBox(
            height: 4,
          ),
          FloatingActionButton(
            onPressed: _singInUser,
            tooltip: 'Sign In',
            child: const Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
