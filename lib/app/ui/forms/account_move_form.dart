import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:banck_accounts_cards/app/data/database/databases.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:banck_accounts_cards/app/controllers/account_move_form_controller.dart';
import 'package:flutter/services.dart';

class AccountMoveForm extends GetView<AccountMoveFormController> {
  final NavigationController navController = Get.put(NavigationController());
  final Databases database = Get.find<Databases>();
  final Rx<String?> selectedCuentaBancariaPersonal = Rx<String?>(null);
  RxList<String> cuentasPersonalesBanco = ['Efectivo', 'P348'].obs;
  RxList<String> cuentas = [
    'Efectivo',
    'AP221',
    'E210',
    'P348',
    'Diners',
    'C092',
    'J406',
    'Banco 1',
    'Banco 2'
  ].obs;
  RxList<String> cuentasInterna = [
    'ANTICIPO',
    'EVENTOS',
    'INGRESO EVENTOS',
    'INVERSION',
    'PRESTAMOS',
    'RENDIMIENTOS FINANCIEROS',
    'UTILIDADES'
  ].obs;
  RxList<String> cuentasPersonales = [
    'Alicuotas Edificio Lisboa',
    'Contabilidad Personal Paul Monsalve',
    'Hermanos Monsalve Moscoso',
    'Arriendos Familia',
  ].obs;
  final Rx<String?> selectedCuenta = Rx<String?>(null);
  final Rx<String?> selectedCuentaInterna = Rx<String?>(null);
  RxList<String> clientes = ['test'].obs;
  RxBool isActiveTextField = false.obs;
  RxDouble saldo = 0.0.obs;
  final Rx<String?> selectedCliente = Rx<String?>(null);
  RxBool isIngresoEnabled = true.obs;
  RxBool isEgresoEnabled = true.obs;
  RxBool isPersonalAccount = false.obs;

  AccountMoveForm({super.key});

  void fechData() async {
    clientes.value = await database.getAllClients();
    saldo.value = await database.getTotalSaldo(controller.cuenta.value);
    controller.saldo.value = saldo.value;
  }

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
      selectedCuenta.value = accountOrigin;
      isPersonalAccount.value = false;
    } else {
      if (accountOrigin != null && cuentasPersonales.contains(accountOrigin)) {
        controller.cuenta.value = accountOrigin;
        selectedCuenta.value = accountOrigin;
        isPersonalAccount.value = true;
      } else {
        controller.cuenta.value = '';
        selectedCuenta.value = null;
      }
    }
    fechData();
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
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return CheckboxListTile(
                      title: const Text('Usar cuentas personales'),
                      value: isPersonalAccount.value,
                      onChanged: (newValue) {
                        isPersonalAccount.value = newValue!;
                        selectedCuenta.value = null;
                      },
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() {
                    return DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Seleccione Cuenta *'),
                      value: selectedCuenta.value,
                      onChanged: (newValue) {
                        selectedCuenta.value = newValue;
                        controller.cuenta.value = newValue!;
                      },
                      items: (isPersonalAccount.value
                              ? cuentasPersonales
                              : cuentas)
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
                  child: Obx(() {
                    return isPersonalAccount.value
                        ? DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text(
                                'Seleccione Cuenta Bancaria Personal'),
                            value: selectedCuentaBancariaPersonal.value,
                            onChanged: (newValue) {
                              selectedCuentaBancariaPersonal.value = newValue;
                              controller.cuentaBancariaPersonal.value =
                                  newValue!;
                            },
                            items: cuentasPersonalesBanco.map((cuenta) {
                              return DropdownMenuItem<String>(
                                value: cuenta,
                                child: Text(cuenta),
                              );
                            }).toList(),
                          )
                        : Container();
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Seleccione Cuenta'),
                      value: selectedCuentaInterna.value,
                      onChanged: (newValue) {
                        selectedCuentaInterna.value = newValue;
                        controller.cuentaIntera.value = newValue!;
                      },
                      items: cuentasInterna.map((cuenta) {
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
                  child: Obx(() => _buildListTile(
                        title: "Fecha",
                        date: controller.selectedFecha.value,
                        onTap: () => controller.pickFecha(context),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() => _buildListTile(
                        title: "Fecha Compra",
                        date: controller.selectedFechaCompra.value,
                        onTap: () => controller.pickFechaCompra(context),
                      )),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Row(
              children: [
                const Text('Es un nuevo proveedor ?'),
                Obx(() {
                  return Checkbox(
                    value: isActiveTextField.value,
                    onChanged: (newValue) {
                      isActiveTextField.value = newValue!;
                    },
                  );
                }),
                Expanded(
                  child: Obx(() {
                    return isActiveTextField.value
                        ? _buildTextField(
                            labelText: 'Cliente/Proveedor',
                            keyboardType: TextInputType.text,
                            onChanged: (value) =>
                                controller.clienteProveedor.value = value,
                          )
                        : DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Seleccione Cliente/Proveedor *'),
                            value: selectedCliente.value,
                            onChanged: (newValue) {
                              selectedCliente.value = newValue;
                              controller.clienteProveedor.value = newValue!;
                            },
                            items: clientes.map((cliente) {
                              return DropdownMenuItem<String>(
                                value: cliente,
                                child: Text(cliente),
                              );
                            }).toList(),
                          );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Número Factura *',
                    keyboardType: TextInputType.text,
                    onChanged: (value) =>
                        controller.numeroFactura.value = value,
                  ),
                ),
              ],
            ),
            _buildTextField(
              labelText: 'Descripción  *',
              maxLines: 5,
              onChanged: (value) => controller.descripcion.value = value,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    labelText: 'Número CI *',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.numeroCI.value = value,
                  ),
                ),
                // const SizedBox(width: 10),
                // Expanded(
                //   child: Obx(() => _buildListTile(
                //         title: "Fecha Pago",
                //         date: controller.selectedFechaPago.value,
                //         onTap: () => controller.pickFechaPago(context),
                //       )),
                // ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() => _buildTextField(
                        labelText: 'Ingreso *',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          controller.ingreso.value =
                              double.tryParse(value) ?? 0.0;
                          isEgresoEnabled.value = value.isEmpty;
                          if (!isEgresoEnabled.value) {
                            controller.egreso.value = 0.0;
                          }
                        },
                        isEnabled: isIngresoEnabled.value,
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() => _buildTextField(
                        labelText: 'Egreso *',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          controller.egreso.value =
                              double.tryParse(value) ?? 0.0;
                          isIngresoEnabled.value = value.isEmpty;
                          if (!isIngresoEnabled.value) {
                            controller.ingreso.value = 0.0;
                          }
                        },
                        isEnabled: isEgresoEnabled.value,
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(
                    () => _buildTextField(
                      isEnabled: false,
                      labelText: 'Saldo',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => controller.saldo.value =
                          double.tryParse(value) ?? 0.0,
                      controller:
                          TextEditingController(text: saldo.value.toString()),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Total *',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) =>
                        controller.total.value = double.tryParse(value) ?? 0.0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Retención',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.retencion.value =
                        double.tryParse(value) ?? 0.0,
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
                        child: const Text('Crear'),
                      ),
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
          ]),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      required String labelText,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      int maxLines = 1,
      required ValueChanged<String> onChanged,
      bool isEnabled = true}) {
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

  Widget _buildListTile({
    required String title,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text("$title: ${DateFormat('yyyy-MM-dd').format(date)}"),
      trailing: const Icon(Icons.calendar_today),
      onTap: onTap,
    );
  }
}
