import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/authentication_controller.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // Inyectar el controlador de Autenticacion
  AuthenticationController ctrl = Get.find();
  // Controladores para las cajas de texto
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _pswdCtrl = TextEditingController();

  void _createUser() async {
    try {
      await ctrl.createUser(_userCtrl.text, _pswdCtrl.text);

      Get.snackbar(
        'User Creation',
        'User created!',
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
      _userCtrl.clear();
      _pswdCtrl.clear();
    } catch (e) {
      Get.snackbar(
        'User Creation',
        e.toString(),
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email:",
                  ),
                  controller: _userCtrl,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password:",
                  ),
                  controller: _pswdCtrl,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _createUser,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
