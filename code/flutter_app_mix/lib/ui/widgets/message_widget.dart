import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/message.dart';
import '../../domain/controllers/authentication_controller.dart';
import '../../domain/controllers/message_controller.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key}) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  // Controladores Get
  AuthenticationController authCtrl = Get.find();
  MessageController msgCtrl = Get.find();
  // Controladores Widgets
  final TextEditingController _msgCtrl = TextEditingController();

  // Metodo para iniciar la instancia de los listeners
  @override
  void initState() {
    super.initState();
    msgCtrl.start();
  }

  // Metodo para detener la instancia de los listeners
  @override
  void dispose() {
    msgCtrl.stop();
    super.dispose();
  }

  Future<void> _addMessage() async {
    await msgCtrl.addMessage(
        Message(_msgCtrl.text, authCtrl.getUserId(), authCtrl.getUserEmail()));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Message",
      ),
      controller: _msgCtrl,
      onSubmitted: (value) async {
        await _addMessage();
        _msgCtrl.clear();
      },
    );
  }
}
