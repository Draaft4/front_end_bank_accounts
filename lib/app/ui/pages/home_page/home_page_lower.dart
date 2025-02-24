import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/ui/pages/accounting_page/accounting_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/advance_page/advance_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/ap221_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/e210_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bp_pages/p348_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/caja_page/caja_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/cash_page/cash_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/dashboard_page/dashboard_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/diners_page/diners_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/event_entry_page/event_entry_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/events_page/events_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/financial_returns_page/financial_returns_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/invesment_page/invesment_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/jep_pages/jepJ406_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/loans_page/loans_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/utilities_page/utilities_page.dart';
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
    CashPage cashPage = CashPage();
    AdvancePage advancePage = AdvancePage();
    EventosPage eventosPage = EventosPage();
    EventEntryPage eventEntryPage = EventEntryPage();
    InvesmentPage invesmentPage = InvesmentPage();
    LoansPage loansPage = LoansPage();
    FinancialReturnsPage financialReturnsPage = FinancialReturnsPage();
    UtilitiesPage utilitiesPage = UtilitiesPage();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(child: sideBar()),
          Obx(() {
            switch (navController.selectedPage.value) {
              case 'Principal':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: dashboardPage.dasboard(context),
                );
              case 'Contabilidad':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: accountingPage.dasboard(context),
                );
              case 'Efectivo':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: cashPage.dasboard(context),
                );
              case 'Cuenta Pichincha E210':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: e210AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha P348':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: p348AccountPage.dasboard(context),
                );
              case 'Cuenta Pichincha AP221':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: ap221AccountPage.dasboard(context),
                );
              case 'Cuenta Diners Club':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: dinersAccountPage.dasboard(context),
                );
              case 'Cuenta JEP J406':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: jep3406AccountPage.dasboard(context),
                );
              case 'Cuenta Coop Caja':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: cajaAccountPage.dasboard(context),
                );
              case 'Cuenta Anticipos':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: advancePage.dasboard(context),
                );
              case 'Cuenta Eventos':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: eventosPage.dasboard(context),
                );
              case 'Cuenta Ingreso Eventos':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: eventEntryPage.dasboard(context),
                );
              case 'Cuenta Inversion':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: invesmentPage.dasboard(context),
                );
              case 'Cuenta Prestamos':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: loansPage.dasboard(context),
                );
              case 'Cuenta Rend. Financieros':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: financialReturnsPage.dasboard(context),
                );
              case 'Cuenta Utilidades':
                return SizedBox(
                  width: screenWidth - 182,
                  height: screenHeight,
                  child: utilitiesPage.dasboard(context),
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
          optionsButton("Principal", Icons.dashboard, 'Principal'),
          optionsButton(
              "Contabilidad", Icons.analytics_outlined, 'Contabilidad'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Cuentas Bancarias"),
              ),
            ),
          ),
          optionsButton("Efectivo", Icons.money, 'Efectivo'),
          optionsButton("Cuenta Pichincha E210", 'static/bp_logo.png', 'E210'),
          optionsButton("Cuenta Pichincha P348", 'static/bp_logo.png', 'P348'),
          optionsButton(
              "Cuenta Pichincha AP221", 'static/bp_logo.png', 'AP221'),
          optionsButton("Cuenta Diners Club", 'static/diners_logo.png', 'DC'),
          optionsButton("Cuenta JEP J406", 'static/jep_logo.png', '3406'),
          optionsButton("Cuenta Coop Caja", 'static/caja_logo.png', 'CAJA'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Cuentas Internas"),
              ),
            ),
          ),
          optionsButton("Cuenta Anticipos", Icons.attach_money, 'Anticipos'),
          optionsButton("Cuenta Eventos", Icons.event, 'Eventos'),
          optionsButton("Cuenta Ingreso Eventos", Icons.monetization_on,
              'Ingreso Eventos'),
          optionsButton("Cuenta Inversion", Icons.trending_up, 'Inversion'),
          optionsButton(
              "Cuenta Prestamos", Icons.account_balance_wallet, 'Prestamos'),
          optionsButton("Cuenta Rend. Financieros", Icons.show_chart,
              'Rend. Financieros'),
          optionsButton("Cuenta Utilidades", Icons.pie_chart, 'Utilidades'),
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
