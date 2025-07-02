import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(() {
            return AnimatedContainer(
              width: controller.isAnimating.value ? 500 : 100,
              height: controller.isAnimating.value ? 500 : 100,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              //child: Image.asset('static/logo.png'),
              child: Text(
                'Contabilidad',
                style: TextStyle(
                  fontSize: controller.isAnimating.value ? 32 : 16,
                  color: Colors.blue,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
