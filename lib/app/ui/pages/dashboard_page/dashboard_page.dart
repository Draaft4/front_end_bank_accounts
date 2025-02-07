import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:banck_accounts_cards/app/ui/pages/exporter_page/exporter_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage {
  final ApiServiceAccounting apiService = Get.find<ApiServiceAccounting>();
  RxBool isLoading = false.obs;
  RxDouble balanceAp221 = 0.0.obs;
  RxDouble balanceE210 = 0.0.obs;
  RxDouble balanceP348 = 0.0.obs;
  RxDouble balanceDiners = 0.0.obs;
  RxDouble balanceJ406 = 0.0.obs;
  RxDouble balanceC092 = 0.0.obs;

  final ScrollController _scrollController = ScrollController();

  void fetchData() async {
    isLoading.value = true;
    balanceDiners.value = await apiService.getBalance('Diners');
    balanceJ406.value = await apiService.getBalance('J406');
    balanceC092.value = await apiService.getBalance('C092');
    balanceAp221.value = await apiService.getBalance('AP221');
    balanceE210.value = await apiService.getBalance('E210');
    balanceP348.value = await apiService.getBalance('P348');
    isLoading.value = false;
  }

  Widget dasboard(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
        actions: [
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCard('Balance total AP221', 'static/bp_logo.png',
                            balanceAp221.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total E210', 'static/bp_logo.png',
                            balanceE210.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total P348', 'static/bp_logo.png',
                            balanceP348.value.toString()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCard('Balance total CAJA', 'static/caja_logo.png',
                            balanceC092.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard('Balance total JEP', 'static/jep_logo.png',
                            balanceJ406.value.toString()),
                        const SizedBox(width: 20),
                        _buildCard(
                            'Balance total Diners Club',
                            'static/diners_logo.png',
                            balanceDiners.value.toString()),
                        const SizedBox(width: 20),
                      ],
                    ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 50, width: 50),
            const SizedBox(height: 10),
            Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
