import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/controllers/authentication_controller.dart';
import '../../domain/controllers/my_camera_controller.dart';
import '../widgets/camera_widget.dart';
import '../widgets/message_widget.dart';
import '../widgets/my_location_view_widget.dart';
import '../widgets/person_view_widget.dart';
import '../widgets/person_widget.dart';
import '../widgets/preview_widget.dart';

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
    const MyLocationViewWidget(),
    const CameraWidget(),
    const PreviewWidget(),
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
    final MyCameraController cameraController = Get.find<MyCameraController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $user"),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: _widgets.elementAt(_selectIndex),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          // Verificar si la camara ha sido iniciada
          if (cameraController.initCamera) {
            try {
              // Tomar foto
              final image = await cameraController.controller.takePicture();
              // Asignar path a nuestro controlador
              cameraController.path = image.path;
              // Cambiar a previsualizar
              setState(() {
                _selectIndex = 5;
              });
            } catch (e) {
              logError(e);
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_search,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.gps_fixed,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: '',
          ),
        ],
        currentIndex: _selectIndex,
        unselectedItemColor: Colors.blueGrey,
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
