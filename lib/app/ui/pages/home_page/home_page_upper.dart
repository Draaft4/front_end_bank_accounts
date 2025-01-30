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

class HomePageUpper {
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
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: dashboardPage.dasboard(context),
                );
              case 'Contabilidad':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: accountingPage.dasboard(context),
                );
              case 'Cuenta Pichincha E210':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: e210AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha P348':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: p348AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha AP221':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: ap221AccountPage.dasboard(context),
                );
              case 'Cuenta Diners Club':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: dinersAccountPage.dasboard(context),
                );
              case 'Cuenta Jep J406':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: jep3406AccountPage.dasboard(context),
                );
              case 'Cuenta Coop Caja':
                return SizedBox(
                  width: screenWidth - 266,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          logoImg(),
          const Divider(),
          const Divider(),
          optionsButton("Principal", Icons.dashboard),
          optionsButton("Contabilidad", Icons.analytics_outlined),
          optionsButton("Cuenta Pichincha E210", 'static/bp_logo.png'),
          optionsButton("Cuenta Pichincha P348", 'static/bp_logo.png'),
          optionsButton("Cuenta Pichincha AP221", 'static/bp_logo.png'),
          optionsButton("Cuenta Diners Club", 'static/diners_logo.png'),
          optionsButton("Cuenta Jep J406", 'static/jep_logo.png'),
          optionsButton("Cuenta Coop Caja", 'static/caja_logo.png'),
        ],
      ),
    );
  }

  Widget optionsButton(String buttonText, dynamic icon) {
    return GestureDetector(
      onTap: () => navController.selectPage(buttonText),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: navController.selectedPage.value == buttonText
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
            Text(buttonText),
          ],
        ),
      ),
    );
  }

  Widget userCard(String username, IconData icon) {
    return Row(
      children: [
        const SizedBox(width: 25),
        Icon(icon),
        const SizedBox(width: 5),
        Text(username),
      ],
    );
  }

  Widget logoImg() {
    return SizedBox(
      height: 20,
      width: 250,
      child: Image.asset("static/logo.png"),
    );
  }
}
