import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/ui/pages/accounting_page/accounting_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/other_accounts_pages/bank1_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/other_accounts_pages/bank2_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/advance_page/advance_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/bp_pages/ap221_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/bp_pages/e210_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/bp_pages/p348_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/caja_page/caja_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/cash_page/cash_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/dashboard_page/dashboard_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/diners_page/diners_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/event_entry_page/event_entry_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/events_page/events_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/financial_returns_page/financial_returns_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/invesment_page/invesment_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/bank_accounts/jep_pages/jepJ406_account_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/loans_page/loans_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/internal_accounts/utilities_page/utilities_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/personal_accounts/family_leases_page/family_leases_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/personal_accounts/lisboa_building_page/lisboa_building_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/personal_accounts/monsalve_moscoso_page/monsalve_moscoso_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/personal_accounts/paul_monsalve_page/paul_monsalve_page.dart';
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
    AdvancePage advancePage = AdvancePage();
    EventosPage eventosPage = EventosPage();
    EventEntryPage eventEntryPage = EventEntryPage();
    InvesmentPage invesmentPage = InvesmentPage();
    LoansPage loansPage = LoansPage();
    FinancialReturnsPage financialReturnsPage = FinancialReturnsPage();
    UtilitiesPage utilitiesPage = UtilitiesPage();
    CashPage cashPage = CashPage();
    LisboaBuildingPage lisboaBuildingPage = LisboaBuildingPage();
    PaulMonsalvePage paulMonsalvePage = PaulMonsalvePage();
    MonsalveMoscosoPage monsalveMoscosoPage = MonsalveMoscosoPage();
    FamilyLeasesPage familyLeasesPage = FamilyLeasesPage();
    Bank1Page bank1Page = Bank1Page();
    Bank2Page bank2Page = Bank2Page();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
              case 'Efectivo':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: cashPage.dasboard(context),
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
              case 'Cuenta Banco 1':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: bank1Page.dasboard(context),
                );
              case 'Cuenta Banco 2':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: bank2Page.dasboard(context),
                );
              case 'Cuenta Anticipos':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: advancePage.dasboard(context),
                );
              case 'Cuenta Eventos':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: eventosPage.dasboard(context),
                );
              case 'Cuenta Ingreso Eventos':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: eventEntryPage.dasboard(context),
                );
              case 'Cuenta Inversion':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: invesmentPage.dasboard(context),
                );
              case 'Cuenta Prestamos':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: loansPage.dasboard(context),
                );
              case 'Cuenta Rend. Financieros':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: financialReturnsPage.dasboard(context),
                );
              case 'Cuenta Utilidades':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: utilitiesPage.dasboard(context),
                );
              case 'Alicuotas Edificio Lisboa':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: lisboaBuildingPage.dasboard(context),
                );
              case 'Cont. Pers. Paul Monsalve':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: paulMonsalvePage.dasboard(context),
                );
              case 'Hnos. Monsalve Moscoso':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: monsalveMoscosoPage.dasboard(context),
                );
              case 'Arriendos Familia':
                return SizedBox(
                  width: screenWidth - 266,
                  height: screenHeight,
                  child: familyLeasesPage.dasboard(context),
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
          //logoImg(),
          const Divider(),
          const Divider(),
          optionsButton("Principal", Icons.dashboard),
          optionsButton("Contabilidad", Icons.analytics_outlined),
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
          optionsButton("Efectivo", Icons.money),
          optionsButton("Cuenta Pichincha E210", 'static/bp_logo.png'),
          optionsButton("Cuenta Pichincha P348", 'static/bp_logo.png'),
          optionsButton("Cuenta Pichincha AP221", 'static/bp_logo.png'),
          optionsButton("Cuenta Diners Club", 'static/diners_logo.png'),
          optionsButton("Cuenta Jep J406", 'static/jep_logo.png'),
          optionsButton("Cuenta Coop Caja", 'static/caja_logo.png'),
          optionsButton("Cuenta Banco 1", Icons.account_balance_wallet_rounded),
          optionsButton("Cuenta Banco 2", Icons.account_balance_wallet_rounded),
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
          optionsButton("Cuenta Anticipos", Icons.attach_money),
          optionsButton("Cuenta Eventos", Icons.event),
          optionsButton("Cuenta Ingreso Eventos", Icons.monetization_on),
          optionsButton("Cuenta Inversion", Icons.trending_up),
          optionsButton("Cuenta Prestamos", Icons.account_balance_wallet),
          optionsButton("Cuenta Rend. Financieros", Icons.show_chart),
          optionsButton("Cuenta Utilidades", Icons.pie_chart),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Cuentas Personales"),
              ),
            ),
          ),
          optionsButton("Alicuotas Edificio Lisboa", Icons.apartment_sharp),
          optionsButton("Cont. Pers. Paul Monsalve", Icons.account_circle),
          optionsButton("Hnos. Monsalve Moscoso", Icons.family_restroom),
          optionsButton("Arriendos Familia", Icons.add_home_work_rounded),
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
