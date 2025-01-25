import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountMoveFormController extends GetxController {
  var selectedFecha = DateTime.now().obs;
  var selectedFechaCompra = DateTime.now().obs;
  var selectedFechaPago = DateTime.now().obs;

  var cuenta = ''.obs;
  var clienteProveedor = ''.obs;
  var numeroFactura = ''.obs;
  var numeroCI = ''.obs;
  var descripcion = ''.obs;
  var ingreso = 0.0.obs;
  var egreso = 0.0.obs;
  var saldo = 0.0.obs;
  var total = 0.0.obs;
  var retencion = 0.0.obs;
  var mesAno = ''.obs;

  TextEditingController cuentaController = TextEditingController();
  ApiServiceAccounting apiService = Get.find<ApiServiceAccounting>();
  @override
  void onInit() {
    super.onInit();
    cuentaController.text = cuenta.value;
  }

  void pickFecha(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFecha.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFecha.value) {
      selectedFecha.value = picked;
    }
  }

  void pickFechaCompra(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFechaCompra.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFechaCompra.value) {
      selectedFechaCompra.value = picked;
    }
  }

  void pickFechaPago(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFechaPago.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFechaPago.value) {
      selectedFechaPago.value = picked;
    }
  }

  void createMovimientoContable() {
    MovimientoContable movimiento = MovimientoContable(
      fecha: selectedFecha.value,
      fechaCompra: selectedFechaCompra.value,
      mesAno: mesAno.value,
      fechaPago: selectedFechaPago.value,
      cuenta: cuenta.value,
      clienteProveedor: clienteProveedor.value,
      numeroFactura: numeroFactura.value,
      numeroCI: numeroCI.value,
      descripcion: descripcion.value,
      ingreso: ingreso.value,
      egreso: egreso.value,
      saldo: saldo.value,
      total: total.value,
      retencion: retencion.value,
    );
    apiService.createAccountMove(movimiento);
    Get.back();
  }
}
