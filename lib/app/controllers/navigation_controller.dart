import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedPage = 'Principal'.obs;

  void selectPage(String page) {
    selectedPage.value = page;
  }

  String selectedOption() {
    return selectedPage.value;
  }
}
