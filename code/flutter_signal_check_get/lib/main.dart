import 'package:flutter/material.dart';
import 'package:flutter_signal_check_get/controllers/signal_controller.dart';
import 'package:get/get.dart';

import 'ui/app.dart';

void main() {
  Get.lazyPut<SignalController>(() => SignalController());
  runApp(const MyApp());
}
