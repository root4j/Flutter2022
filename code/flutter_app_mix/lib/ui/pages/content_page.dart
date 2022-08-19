import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/controllers/authentication_controller.dart';
import '../widgets/message_widget.dart';
import '../widgets/person_view_widget.dart';
import '../widgets/person_widget.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // Index del widget actual
  int _selectIndex = 0;
  // Listado de Widgets disponibles
  final List<Widget> _widgets = <Widget>[
    const MessageWidget(),
    const PersonWidget(),
    const PersonViewWidget(),
  ];

  // Controladores
  AuthenticationController authCtrl = Get.find();

  _logout() async {
    try {
      await authCtrl.signOut();
    } catch (e) {
      logError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = authCtrl.getUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $user"),
        actions: [
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
            ),
            label: 'Create Persons',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search,
            ),
            label: 'View Persons',
          ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.blue[200],
        onTap: (value) {
          setState(() {
            _selectIndex = value;
          });
        },
      ),
    );
  }
}
