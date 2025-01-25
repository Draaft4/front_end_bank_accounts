import 'package:get/get.dart';

class HomeController extends GetxController {
  var screenWidth = 0.0.obs;
  var screenHeight = 0.0.obs;

  void updateDimensions(double width, double height) {
    screenWidth.value = width;
    screenHeight.value = height;
  }
}
