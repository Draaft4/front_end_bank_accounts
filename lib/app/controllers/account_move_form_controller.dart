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
  var cuentaIntera = ''.obs;

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
    List<String> camposVacios = [];

    if (cuenta.value.isEmpty) camposVacios.add('Cuenta');
    if (clienteProveedor.value.isEmpty) camposVacios.add('Cliente/Proveedor');
    if (numeroFactura.value.isEmpty) camposVacios.add('Número de Factura');
    if (numeroCI.value.isEmpty) camposVacios.add('Número de CI');
    if (descripcion.value.isEmpty) camposVacios.add('Descripción');
    if (camposVacios.isNotEmpty) {
      Get.snackbar(
        'Error',
        'Los siguientes campos deben tener un valor válido: ${camposVacios.join(", ")}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

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
      cuentaInterna: cuentaIntera.value,
    );
    apiService.createAccountMove(movimiento);
    Get.back();
  }

  var screenWidth = 0.0.obs;
  var screenHeight = 0.0.obs;

  void updateDimensions(double width, double height) {
    screenWidth.value = width;
    screenHeight.value = height;
  }
}
