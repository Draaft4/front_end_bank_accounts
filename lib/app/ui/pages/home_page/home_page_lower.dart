import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/ui/pages/accounting_page/accounting_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/ap221_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/e210_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/p348_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/caja_page/caja_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/dashboard_page/dashboard_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/diners_page/diners_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/jep_pages/jepJ406_account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageLower {
  final NavigationController navController = Get.find();

  Widget body(BuildContext context, double screenWidth, double screenHeight) {
    DashboardPage dashboardPage = DashboardPage();
    AccountingPage accountingPage = AccountingPage();
    E210AccountPage e210AccountPage = E210AccountPage();
    P348AccountPage p348AccountPage = P348AccountPage();
    AP221AccountPage ap221AccountPage = AP221AccountPage();
    CAJAAccountPage cajaAccountPage = CAJAAccountPage();
    DinersAccountPage dinersAccountPage = DinersAccountPage();
    JEPJ406AccountPage jep3406AccountPage = JEPJ406AccountPage();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(child: sideBar()),
          Obx(() {
            switch (navController.selectedPage.value) {
              case 'Principal':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: dashboardPage.dasboard(context),
                );
              case 'Contabilidad':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: accountingPage.dasboard(context),
                );
              case 'Cuenta Pichincha E210':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: e210AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha P348':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: p348AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha AP221':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: ap221AccountPage.dasboard(context),
                );
              case 'Cuenta Diners Club':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: dinersAccountPage.dasboard(context),
                );
              case 'Cuenta JEP J406':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: jep3406AccountPage.dasboard(context),
                );
              case 'Cuenta Coop Caja':
                return SizedBox(
                  width: screenWidth - 107,
                  height: screenHeight,
                  child: cajaAccountPage.dasboard(context),
                );
              default:
                return const Center(child: Text("Page not found"));
            }
          }),
        ],
      ),
    );
  }

  Widget sideBar() {
    return SingleChildScrollView(
      child: Column(
        children: [
          optionsButton("Principal", Icons.dashboard, ''),
          optionsButton("Contabilidad", Icons.analytics_outlined, ''),
          optionsButton("Cuenta Pichincha E210", 'static/bp_logo.png', 'E210'),
          optionsButton("Cuenta Pichincha P348", 'static/bp_logo.png', 'P348'),
          optionsButton(
              "Cuenta Pichincha AP221", 'static/bp_logo.png', 'AP221'),
          optionsButton("Cuenta Diners Club", 'static/diners_logo.png', 'DC'),
          optionsButton("Cuenta JEP J406", 'static/jep_logo.png', '3406'),
          optionsButton("Cuenta Coop Caja", 'static/caja_logo.png', 'CAJA'),
        ],
      ),
    );
  }

  Widget optionsButton(String selected, dynamic icon, String code) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => navController.selectPage(selected),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: navController.selectedPage.value == selected
                  ? Colors.blue[100]
                  : Colors.transparent,
              child: Row(
                children: [
                  icon is IconData
                      ? Icon(icon)
                      : Container(
                          color: Colors.white24,
                          height: 20,
                          width: 20,
                          child: Image.asset(icon),
                        ),
                  const SizedBox(width: 10),
                  Text(code),
                ],
              ),
            )),
        const Divider(),
      ],
    );
  }
}
