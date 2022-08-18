import 'package:flutter/material.dart';
import 'package:flutter_app_mix/ui/widgets/message_widget.dart';
import 'package:get/get.dart';

import '../../domain/controllers/authentication_controller.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  // Controladores
  AuthenticationController authCtrl = Get.find();

  _logout() async {
    try {
      await authCtrl.signOut();
    } catch (e) {}
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
      body: const MessageWidget(),
    );
  }
}
