import 'package:banck_accounts_cards/app/controllers/home_controller.dart';
import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/ui/pages/home_page/home_page_lower.dart';
import 'package:banck_accounts_cards/app/ui/pages/home_page/home_page_upper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  final NavigationController navController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    controller.updateDimensions(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    HomePageUpper upper = HomePageUpper();
    HomePageLower lower = HomePageLower();
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.screenWidth.value > 900) {
            return upper.body(context, controller.screenWidth.value,
                controller.screenHeight.value);
          } else {
            return lower.body(context, controller.screenWidth.value,
                controller.screenHeight.value);
          }
        }),
      ),
    );
  }
}
