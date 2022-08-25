import 'package:camera/camera.dart';
import 'package:get/get.dart';

class MyCameraController extends GetxController {
  // Variables Observables
  final Rx<CameraDescription> _camera;
  late Rx<CameraController> _controller;
  final _path = "".obs;
  final _initCamera = false.obs;

  // Getters
  CameraDescription get camera => _camera.value;
  CameraController get controller => _controller.value;
  String get path => _path.value;
  bool get initCamera => _initCamera.value;

  // Setters
  set controller(CameraController controller) {
    _controller = Rx<CameraController>(controller);
  }

  set path(String path) {
    _path.value = path;
  }

  set initCamera(bool initCamera) {
    _initCamera.value = initCamera;
  }

  // Constructor
  MyCameraController(CameraDescription camera)
      : _camera = Rx<CameraDescription>(camera);
}
