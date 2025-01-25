import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AP221AccountPage {
  final ApiServiceOnAccount apiService = Get.find<ApiServiceOnAccount>();
  RxList<MovimientoContable> movimientos = <MovimientoContable>[].obs;
  RxBool isLoading = false.obs;

  void fetchData() async {
    isLoading.value = true;
    movimientos.value =
        (await apiService.fetchData("AP221")).cast<MovimientoContable>();
    isLoading.value = false;
  }

  Widget dasboard(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pichincha Account AP221'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => AccountMoveForm(),
                  arguments: {'account_origin': 'AP221'});
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              fetchData();
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
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Fecha Compra')),
              DataColumn(label: Text('Mes/Año')),
              DataColumn(label: Text('Cuenta')),
              DataColumn(label: Text('Cliente/Proveedor')),
              DataColumn(label: Text('Número Factura')),
              DataColumn(label: Text('Número CI')),
              DataColumn(label: Text('Descripción')),
              DataColumn(label: Text('Fecha Pago')),
              DataColumn(label: Text('Ingreso')),
              DataColumn(label: Text('Egreso')),
              DataColumn(label: Text('Saldo')),
              DataColumn(label: Text('Total')),
              DataColumn(label: Text('Retención')),
            ],
            rows: movimientos.map((movimiento) {
              return DataRow(cells: [
                DataCell(
                    SizedBox(width: 20, child: Text(movimiento.id.toString()))),
                DataCell(Text(movimiento.fecha != null
                    ? DateFormat('yyyy-MM-dd').format(movimiento.fecha!)
                    : '')),
                DataCell(Text(movimiento.fechaCompra != null
                    ? DateFormat('yyyy-MM-dd').format(movimiento.fechaCompra!)
                    : '')),
                DataCell(Text(movimiento.mesAno ?? '')),
                DataCell(Text(movimiento.cuenta ?? '')),
                DataCell(Text(movimiento.clienteProveedor ?? '')),
                DataCell(Text(movimiento.numeroFactura ?? '')),
                DataCell(Text(movimiento.numeroCI ?? '')),
                DataCell(Text(movimiento.descripcion ?? '')),
                DataCell(Text(movimiento.fechaPago != null
                    ? DateFormat('yyyy-MM-dd').format(movimiento.fechaPago!)
                    : '')),
                DataCell(Text(movimiento.ingreso?.toString() ?? '')),
                DataCell(Text(movimiento.egreso?.toString() ?? '')),
                DataCell(Text(movimiento.saldo?.toString() ?? '')),
                DataCell(Text(movimiento.total?.toString() ?? '')),
                DataCell(Text(movimiento.retencion?.toString() ?? '')),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
