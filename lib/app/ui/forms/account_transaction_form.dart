import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/data/database/databases.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banck_accounts_cards/app/controllers/account_transaction_form_controller.dart';
import 'package:flutter/services.dart';

class AccountTransactionForm extends GetView<AccountTransactionFormController> {
  final NavigationController navController = Get.put(NavigationController());
  final Databases database = Get.find<Databases>();
  RxList<String> cuentas =
      ['Efectivo', 'AP221', 'E210', 'P348', 'Diners', 'C092', 'J406'].obs;
  final Rx<String?> selectedCuentaOrigen = Rx<String?>(null);
  final Rx<String?> selectedCuentaDestino = Rx<String?>(null);
  RxBool isIngresoEnabled = true.obs;
  RxBool isEgresoEnabled = true.obs;

  @override
  Widget build(BuildContext context) {
    controller.updateDimensions(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    final args = Get.arguments;
    final accountOrigin = args['account_origin'];
    if (accountOrigin != null && cuentas.contains(accountOrigin)) {
      controller.cuenta.value = accountOrigin;
      selectedCuentaOrigen.value = accountOrigin;
    } else {
      controller.cuenta.value = '';
      selectedCuentaOrigen.value = null;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear nuevo movimiento contable'),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Cuenta Origen'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Seleccione Cuenta Bancaria'),
                        value: selectedCuentaOrigen.value,
                        onChanged: (newValue) async {
                          if (selectedCuentaDestino.value == newValue) {
                            selectedCuentaDestino.value = null;
                          }
                          selectedCuentaOrigen.value = newValue;
                          controller.cuentaOrigen.value = newValue!;
                          await controller.getSaldos();
                        },
                        items: cuentas.map((cuenta) {
                          return DropdownMenuItem<String>(
                            value: cuenta,
                            child: Text(cuenta),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => _buildTextField(
                        isEnabled: false,
                        labelText: 'Saldo',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => controller.saldoOrigen.value =
                            double.tryParse(value) ?? 0.0,
                        controller: TextEditingController(
                            text: controller.saldoOrigen.value.toString()),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Cuenta Destino'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Seleccione Cuenta Bancaria'),
                        value: selectedCuentaDestino.value,
                        onChanged: (newValue) async {
                          if (selectedCuentaOrigen.value == newValue) {
                            selectedCuentaOrigen.value = null;
                          }
                          selectedCuentaDestino.value = newValue;
                          controller.cuentaDestino.value = newValue!;
                          await controller.getSaldos();
                        },
                        items: cuentas
                            .where((cuenta) =>
                                cuenta != selectedCuentaOrigen.value)
                            .map((cuenta) {
                          return DropdownMenuItem<String>(
                            value: cuenta,
                            child: Text(cuenta),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => _buildTextField(
                        isEnabled: false,
                        labelText: 'Saldo',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => controller.saldoDestino.value =
                            double.tryParse(value) ?? 0.0,
                        controller: TextEditingController(
                            text: controller.saldoDestino.value.toString()),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Text('Valor Transferencia'),
              const SizedBox(width: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      labelText: 'Valor',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        controller.ingreso.value =
                            double.tryParse(value) ?? 0.0;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.createMovimientoContable();
                          },
                          child: const Text('Transferir'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String labelText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    required ValueChanged<String> onChanged,
    bool isEnabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        enabled: isEnabled,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
