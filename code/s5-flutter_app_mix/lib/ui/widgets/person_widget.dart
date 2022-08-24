import 'package:flutter/material.dart';
import 'package:flutter_app_mix/data/model/person.dart';
import 'package:get/get.dart';

import '../../domain/controllers/person_controller.dart';

class PersonWidget extends StatefulWidget {
  const PersonWidget({Key? key}) : super(key: key);

  @override
  State<PersonWidget> createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {
  // Controladores para las cajas de texto
  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _mailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  // Variables
  String gender = 'Male';
  // Get Controller
  PersonController personCtrl = Get.find();

  // Metodo para iniciar la instancia de los listeners
  @override
  void initState() {
    super.initState();
    personCtrl.start();
  }

  // Metodo para detener la instancia de los listeners
  @override
  void dispose() {
    personCtrl.stop();
    super.dispose();
  }

  // Metodo para agregar usuario
  _newPerson() async {
    try {
      var person = Person(_idCtrl.text, _nameCtrl.text, _mailCtrl.text,
          _phoneCtrl.text, _addressCtrl.text, gender);
      await personCtrl.addPerson(person);
      Get.snackbar(
        'Person Creation',
        'Person created!',
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
      _idCtrl.clear();
      _nameCtrl.clear();
      _mailCtrl.clear();
      _phoneCtrl.clear();
      _addressCtrl.clear();
    } catch (e) {
      Get.snackbar(
        'Person Creation',
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
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Id:",
                  ),
                  controller: _idCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name:",
                  ),
                  controller: _nameCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email:",
                  ),
                  controller: _mailCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Phone:",
                  ),
                  controller: _phoneCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Address:",
                  ),
                  controller: _addressCtrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownButton<String>(
                  value: gender,
                  elevation: 16,
                  borderRadius: BorderRadius.circular(10),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue ?? 'Male';
                    });
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: _newPerson,
                  child: const Text('Create Person'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
