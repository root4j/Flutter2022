import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/person.dart';
import '../../domain/controllers/authentication_controller.dart';
import '../../domain/controllers/person_controller.dart';

class PersonViewWidget extends StatefulWidget {
  const PersonViewWidget({Key? key}) : super(key: key);

  @override
  State<PersonViewWidget> createState() => _PersonViewWidgetState();
}

class _PersonViewWidgetState extends State<PersonViewWidget> {
  // Controladores Get
  AuthenticationController authCtrl = Get.find();
  PersonController personCtrl = Get.find();
  // Controladores Widgets
  final ScrollController _scrollCtrl = ScrollController();

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

  // Widget encargado de mostrar las personas que se encuentren
  // registrados en la base de datos
  Widget _personCard(Person person, int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Name:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.name)
              ],
            ),
            Row(
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.mail)
              ],
            ),
            Row(
              children: [
                const Text(
                  'Address:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(person.address)
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget encargado de mostrar el listado de personas en la
  // base de datos
  Widget _personList() {
    return GetX<PersonController>(
      builder: ((controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        // Ordenamiento
        personCtrl.persons
            .sort(((a, b) => a.activityDate.compareTo(b.activityDate)));
        return ListView.builder(
          itemCount: personCtrl.persons.length,
          controller: _scrollCtrl,
          itemBuilder: ((context, index) {
            var prs = personCtrl.persons[index];
            return _personCard(prs, index);
          }),
        );
      }),
    );
  }

  // Hacer scroll de los mensajes nuevos
  _scrollToEnd() async {
    _scrollCtrl.animateTo(
      _scrollCtrl.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _personList(),
        ),
      ],
    );
  }
}
