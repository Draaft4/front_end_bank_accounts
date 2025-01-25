import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedPage = 'Dashboard'.obs;

  void selectPage(String page) {
    selectedPage.value = page;
  }

  String selectedOption() {
    return selectedPage.value;
  }
}
