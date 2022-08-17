// Libreria para manejar la autenticacion con firebase
import 'package:firebase_auth/firebase_auth.dart';
// Libreria que me permite trabajar con firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'domain/messages_controller.dart';

void main() async {
  // Asegurar que los widgets principales se inicien
  WidgetsFlutterBinding.ensureInitialized();
  // Inyectar controladores
  Get.put(MessagesController());
  // Iniciar la instancia de Firebase
  await Firebase.initializeApp();
  // Ejecutar aplicacion
  runApp(const MyApp());
}

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
  // Controladores para las cajas de texto
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();
  // Variables del Widget
  String _user = '';
  String _pswd = '';

  MessagesController msgCtrl = Get.find();

  void _createUser() async {
    var msg = 'User created!';
    var type = false;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _userCtrl.text, password: _pswdCtrl.text);
      type = true;
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
      if (type) {
        _userCtrl.clear();
        _pswdCtrl.clear();
        _user = "";
        _pswd = "";
      }
      msgCtrl.showNotification(msg);
    });
  }

  void _singInUser() async {
    var msg = 'User authenticated!';
    var type = false;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _user, password: _pswd);
      type = true;
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
      if (type) {
        _userCtrl.clear();
        _pswdCtrl.clear();
        _user = "";
        _pswd = "";
      }
      msgCtrl.showNotification(msg);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email:",
                ),
                controller: _userCtrl,
                onChanged: (value) {
                  setState(() {
                    _user = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password:",
                ),
                controller: _pswdCtrl,
                onChanged: (value) {
                  setState(() {
                    _pswd = value;
                  });
                },
              ),
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
