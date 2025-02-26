import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:get/get.dart';

class AccountTransactionFormController extends GetxController {
  final ApiServiceAccounting apiService = Get.find<ApiServiceAccounting>();
  var screenWidth = 0.0.obs;
  var screenHeight = 0.0.obs;

  DateTime? fecha;
  DateTime? fechaCompra;
  DateTime? fechaPago;
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

  var saldoOrigen = 0.0.obs;
  var cuentaOrigen = ''.obs;

  var saldoDestino = 0.0.obs;
  var cuentaDestino = ''.obs;

  void updateDimensions(double width, double height) {
    screenWidth.value = width;
    screenHeight.value = height;
  }

  Future<void> getSaldos() async {
    saldoOrigen.value = 0.0;
    saldoDestino.value = 0.0;
    saldoOrigen.value = await apiService.getBalance(cuentaOrigen.value);
    saldoDestino.value = await apiService.getBalance(cuentaDestino.value);
  }

  void createMovimientoContable() {
    if (ingreso.value > saldoOrigen.value) {
      Get.snackbar(
        'Error',
        'El valor transferido no puede ser mayor que el saldo de la cuenta de origen.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    fecha = DateTime.now();
    fechaCompra = DateTime.now();
    fechaPago = DateTime.now();
    cuenta.value = cuentaDestino.value;
    clienteProveedor.value = 'Sin asignar';
    numeroFactura.value = 'Sin asignar';
    numeroCI.value = 'Sin asignar';
    descripcion.value = 'Transferencia de $cuentaOrigen a $cuentaDestino';
    egreso.value = 0.0;
    saldo.value = 0.0;
    total.value = 0.0;
    retencion.value = 0.0;
    mesAno.value = '';
    cuentaIntera.value = 'TRANSFERENCIA INTERNA';
    MovimientoContable nuevoMovimientoIngreso = MovimientoContable(
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
      mesAno: mesAno.value,
      cuentaInterna: cuentaIntera.value,
      fecha: fecha,
      fechaCompra: fechaCompra,
      fechaPago: fechaPago,
    );
    apiService.createAccountMove(nuevoMovimientoIngreso);
    cuenta.value = cuentaOrigen.value;
    clienteProveedor.value = 'Sin asignar';
    numeroFactura.value = 'Sin asignar';
    numeroCI.value = 'Sin asignar';
    descripcion.value = 'Transferencia de $cuentaOrigen a $cuentaDestino';
    egreso.value = ingreso.value;
    ingreso.value = 0.0;
    saldo.value = 0.0;
    total.value = 0.0;
    retencion.value = 0.0;
    mesAno.value = '';
    cuentaIntera.value = 'TRANSFERENCIA INTERNA';
    MovimientoContable nuevoMovimientoEgreso = MovimientoContable(
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
      mesAno: mesAno.value,
      cuentaInterna: cuentaIntera.value,
      fecha: fecha,
      fechaCompra: fechaCompra,
      fechaPago: fechaPago,
    );
    apiService.createAccountMove(nuevoMovimientoEgreso);
    Get.back();
    Get.snackbar(
      'Movimiento contable creado',
      'El movimiento contable ha sido creado con éxito.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
