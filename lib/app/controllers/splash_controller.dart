import 'package:banck_accounts_cards/app/controllers/home_controller.dart';
import 'package:banck_accounts_cards/app/ui/pages/home_page/home_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var isAnimating = false.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    isAnimating.value = true;
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => HomePage());
    Get.lazyPut(() => HomeController());
  }
}
