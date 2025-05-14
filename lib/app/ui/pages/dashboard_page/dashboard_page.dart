import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_transaction_form.dart';
import 'package:banck_accounts_cards/app/ui/pages/exporter_page/exporter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage {
  final ApiServiceAccounting apiService = Get.find<ApiServiceAccounting>();
  RxBool isLoading = false.obs;

  // Balances bank accounts
  RxDouble balanceAp221 = 0.0.obs;
  RxDouble balanceE210 = 0.0.obs;
  RxDouble balanceP348 = 0.0.obs;
  RxDouble balanceDiners = 0.0.obs;
  RxDouble balanceJ406 = 0.0.obs;
  RxDouble balanceC092 = 0.0.obs;
  RxDouble balanceCash = 0.0.obs;
  RxDouble balanceBank1 = 0.0.obs;
  RxDouble balanceBank2 = 0.0.obs;
  //Balances personal accounts
  RxDouble balanceLisboaBuilding = 0.0.obs;
  RxDouble balancePaulMonsalve = 0.0.obs;
  RxDouble balanceMonsalveMoscoso = 0.0.obs;
  RxDouble balanceFamilyLeases = 0.0.obs;
  //Total balance
  RxDouble totalBalance = 0.0.obs;

  final ScrollController _scrollController = ScrollController();

  void fetchData() async {
    isLoading.value = true;

    // Fetch data from the API and update the balances bank accounts
    balanceDiners.value = await apiService.getBalance('Diners') -
        await apiService.getRetention('Diners');
    balanceJ406.value = await apiService.getBalance('J406') -
        await apiService.getRetention('J406');
    balanceC092.value = await apiService.getBalance('C092') -
        await apiService.getRetention('C092');
    balanceAp221.value = await apiService.getBalance('AP221') -
        await apiService.getRetention('AP221');
    balanceE210.value = await apiService.getBalance('E210') -
        await apiService.getRetention('E210');
    balanceP348.value = await apiService.getBalance('P348') -
        await apiService.getRetention('P348');
    balanceCash.value = await apiService.getBalance('Efectivo') -
        await apiService.getRetention('Efectivo');
    balanceBank1.value = await apiService.getBalance('Banco 1') -
        await apiService.getRetention('Banco 1');
    balanceBank2.value = await apiService.getBalance('Banco 2') -
        await apiService.getRetention('Banco 2');

    balanceLisboaBuilding.value =
        await apiService.getBalance('Alicuotas Edificio Lisboa') -
            await apiService.getRetention('Alicuotas Edificio Lisboa');
    balancePaulMonsalve.value = await apiService
            .getBalance('Contabilidad Personal Paul Monsalve') -
        await apiService.getRetention('Contabilidad Personal Paul Monsalve');
    balanceMonsalveMoscoso.value =
        await apiService.getBalance('Hermanos Monsalve Moscoso') -
            await apiService.getRetention('Hermanos Monsalve Moscoso');
    balanceFamilyLeases.value =
        await apiService.getBalance('Arriendos Familia') -
            await apiService.getRetention('Arriendos Familia');

    // Calculate the total balance
    totalBalance.value = balanceAp221.value +
        balanceE210.value +
        balanceP348.value +
        balanceDiners.value +
        balanceJ406.value +
        balanceC092.value +
        balanceCash.value +
        balanceBank1.value +
        balanceBank2.value +
        balanceLisboaBuilding.value +
        balancePaulMonsalve.value +
        balanceMonsalveMoscoso.value +
        balanceFamilyLeases.value;

    isLoading.value = false;
  }

  Widget dasboard(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
        actions: [
          CupertinoButton(
              child: const Row(
                children: [
                  Text('Transferencia a cuenta'),
                  SizedBox(width: 10),
                  Icon(Icons.swap_horiz),
                ],
              ),
              onPressed: () {
                Get.to(() => AccountTransactionForm(),
                    arguments: {'account_origin': ''});
              }),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => AccountMoveForm(),
                  arguments: {'account_origin': ''});
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () {
              Get.to(() => ExporterPage(), arguments: {'account_origin': null});
            },
          ),
        ],
      ),
      body: Obx(() {
        if (isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return body();
        }
      }),
    );
  }

  Widget body() {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Resumen de Cuentas Bancarias',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCard('Balance total Efectivo', 'static/money.png',
                            balanceCash.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total AP221', 'static/bp_logo.png',
                            balanceAp221.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total E210', 'static/bp_logo.png',
                            balanceE210.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total P348', 'static/bp_logo.png',
                            balanceP348.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total CAJA', 'static/caja_logo.png',
                            balanceC092.value.toString()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCard('Balance total JEP', 'static/jep_logo.png',
                            balanceJ406.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard(
                            'Balance total Diners Club',
                            'static/diners_logo.png',
                            balanceDiners.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total Banco 1', 'static/bank.png',
                            balanceBank1.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total Banco 2', 'static/bank.png',
                            balanceBank2.value.toString()),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Resumen de Cuentas Personales',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCardI(
                            'Balance total Edificio Lisboa',
                            Icons.apartment_sharp,
                            balanceLisboaBuilding.value.toString()),
                        const SizedBox(width: 20),
                        _buildCardI(
                            'Balance total Paul Monsalve',
                            Icons.account_circle,
                            balancePaulMonsalve.value.toString()),
                        const SizedBox(width: 20),
                        _buildCardI(
                            'Balance total Hermanos Monsalve Moscoso',
                            Icons.family_restroom,
                            balanceMonsalveMoscoso.value.toString()),
                        const SizedBox(width: 20),
                        _buildCardI(
                            'Balance total Arriendos Familia',
                            Icons.add_home_work_rounded,
                            balanceFamilyLeases.value.toString()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Saldo Final:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          totalBalance.value.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Icon(Icons.monetization_on_outlined,
                            size: 25,
                            color: totalBalance.value >= 0
                                ? Colors.green
                                : Colors.red),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(String title, String iconPath, String value) {
    return Card(
      elevation: 4,
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, height: 50, width: 50),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardI(String title, IconData icon, String value) {
    return Card(
      elevation: 4,
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
