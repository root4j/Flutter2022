import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Clase controladora de la señal
class SignalController extends GetxController {
  // Creacion de variables
  final _signal = "".obs;
  final _icon = Icons.access_alarms_sharp.obs;

  // Getters
  String get signal => _signal.value;
  IconData get icon => _icon.value;

  // Futuro para verificar la señal
  void checkSignalType() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          _signal.value = "Wifi";
          _icon.value = Icons.network_wifi;
          break;
        case ConnectivityResult.mobile:
          _signal.value = "Mobile";
          _icon.value = Icons.signal_cellular_0_bar_rounded;
          break;
        default:
          _signal.value = "No Signal";
          _icon.value = Icons.portable_wifi_off;
          break;
      }
    } catch (e) {
      _signal.value = "Error";
      _icon.value = Icons.access_alarms_sharp;
    }
  }
}
