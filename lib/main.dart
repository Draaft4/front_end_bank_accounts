import 'package:banck_accounts_cards/app/bindings/splash_binding.dart';
import 'package:banck_accounts_cards/app/controllers/account_move_form_controller.dart';
import 'package:banck_accounts_cards/app/controllers/account_transaction_form_controller.dart';
import 'package:banck_accounts_cards/app/controllers/exporter_controller.dart';
import 'package:banck_accounts_cards/app/data/database/databases.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/routes/pages.dart';
import 'package:banck_accounts_cards/app/routes/routes.dart';
import 'package:banck_accounts_cards/app/ui/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(Databases());
  Get.put(ApiServiceAccounting());
  Get.put(ApiServiceOnAccount());
  Get.put(AccountMoveFormController());
  Get.put(ExporterController());
  Get.put(AccountTransactionFormController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    defaultTransition: Transition.fade,
    initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    home: const SplashPage(),
  ));
}
