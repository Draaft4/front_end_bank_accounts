import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:banck_accounts_cards/app/controllers/account_move_form_controller.dart';
import 'package:flutter/services.dart';

class AccountMoveForm extends StatelessWidget {
  final AccountMoveFormController controller =
      Get.find<AccountMoveFormController>();

  AccountMoveForm({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: SizedBox(
        width: 750,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: controller.cuentaController,
                  decoration: const InputDecoration(labelText: 'Cuenta'),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => controller.cuenta.value = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => ListTile(
                      title: Text(
                          "Fecha: ${DateFormat('yyyy-MM-dd').format(controller.selectedFecha.value)}"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => controller.pickFecha(context),
                    )),
                Obx(() => ListTile(
                      title: Text(
                          "Fecha Compra: ${DateFormat('yyyy-MM-dd').format(controller.selectedFechaCompra.value)}"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => controller.pickFechaCompra(context),
                    )),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Mes/Año (MM/YYYY)'),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => controller.mesAno.value = value,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Cliente/Proveedor'),
                  keyboardType: TextInputType.text,
                  onChanged: (value) =>
                      controller.clienteProveedor.value = value,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Número Factura'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.numeroFactura.value = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Número CI'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.numeroCI.value = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  maxLines: 5,
                  onChanged: (value) => controller.descripcion.value = value,
                ),
                Obx(() => ListTile(
                      title: Text(
                          "Fecha Pago: ${DateFormat('yyyy-MM-dd').format(controller.selectedFechaPago.value)}"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => controller.pickFechaPago(context),
                    )),
                TextField(
                  decoration: const InputDecoration(labelText: 'Ingreso'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) =>
                      controller.ingreso.value = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Egreso'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) =>
                      controller.egreso.value = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Saldo'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) =>
                      controller.saldo.value = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Total'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      controller.total.value = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Retención'),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.retencion.value =
                      double.tryParse(value) ?? 0.0,
                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
