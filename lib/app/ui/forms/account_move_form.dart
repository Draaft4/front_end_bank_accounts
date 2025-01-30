import 'package:banck_accounts_cards/app/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:banck_accounts_cards/app/controllers/account_move_form_controller.dart';
import 'package:flutter/services.dart';

class AccountMoveForm extends GetView<AccountMoveFormController> {
  final NavigationController navController = Get.put(NavigationController());

  AccountMoveForm({super.key});

  @override
  Widget build(BuildContext context) {
    controller.updateDimensions(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    final args = Get.arguments;
    final accountOrigin = args['account_origin'];
    if (accountOrigin != null) {
      controller.cuenta.value = accountOrigin;
      controller.cuentaController.text = accountOrigin;
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
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: controller.cuentaController,
                    labelText: 'Cuenta',
                    keyboardType: TextInputType.text,
                    onChanged: (value) => controller.cuenta.value = value,
                  ),
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
                Expanded(
                  child: _buildTextField(
                    labelText: 'Mes/Año (MM/YYYY)',
                    keyboardType: TextInputType.text,
                    onChanged: (value) => controller.mesAno.value = value,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    labelText: 'Cliente/Proveedor',
                    keyboardType: TextInputType.text,
                    onChanged: (value) =>
                        controller.clienteProveedor.value = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Número Factura',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) =>
                        controller.numeroFactura.value = value,
                  ),
                ),
              ],
            ),
            _buildTextField(
              labelText: 'Descripción',
              maxLines: 5,
              onChanged: (value) => controller.descripcion.value = value,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    labelText: 'Número CI',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.numeroCI.value = value,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() => _buildListTile(
                        title: "Fecha Pago",
                        date: controller.selectedFechaPago.value,
                        onTap: () => controller.pickFechaPago(context),
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    labelText: 'Ingreso',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => controller.ingreso.value =
                        double.tryParse(value) ?? 0.0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Egreso',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) =>
                        controller.egreso.value = double.tryParse(value) ?? 0.0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Saldo',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) =>
                        controller.saldo.value = double.tryParse(value) ?? 0.0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    labelText: 'Total',
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

  Widget _buildTextField({
    TextEditingController? controller,
    required String labelText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
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
