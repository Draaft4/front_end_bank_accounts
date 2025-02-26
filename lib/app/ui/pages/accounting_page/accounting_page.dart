import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AccountingPage {
  final ApiServiceAccounting apiService = Get.find<ApiServiceAccounting>();
  RxList<MovimientoContable> movimientos = <MovimientoContable>[].obs;
  RxBool isLoading = false.obs;

  final ScrollController _scrollController = ScrollController();

  final TextEditingController idFilterController = TextEditingController();
  final TextEditingController fechaFilterController = TextEditingController();
  final TextEditingController fechaCompraFilterController =
      TextEditingController();
  final TextEditingController cuentaFilterController = TextEditingController();
  final TextEditingController clienteProveedorFilterController =
      TextEditingController();
  final TextEditingController numeroFacturaFilterController =
      TextEditingController();
  final TextEditingController numeroCIFilterController =
      TextEditingController();
  final TextEditingController descripcionFilterController =
      TextEditingController();
  final TextEditingController fechaPagoFilterController =
      TextEditingController();
  final TextEditingController ingresoFilterController = TextEditingController();
  final TextEditingController egresoFilterController = TextEditingController();
  final TextEditingController saldoFilterController = TextEditingController();
  final TextEditingController totalFilterController = TextEditingController();
  final TextEditingController retencionFilterController =
      TextEditingController();
  final TextEditingController cuentaInternaController = TextEditingController();

  RxList<String> cuentas =
      ['Efectivo', 'AP221', 'E210', 'P348', 'Diners', 'C092', 'J406'].obs;
  final Rx<String?> selectedCuenta = Rx<String?>(null);

  void fetchData() async {
    isLoading.value = true;
    List<MovimientoContable> allMovimientos =
        (await apiService.fetchData()).cast<MovimientoContable>();

    // Apply filters
    movimientos.value = allMovimientos.where((movimiento) {
      bool matches = true;
      if (idFilterController.text.isNotEmpty) {
        matches &= movimiento.id.toString().contains(idFilterController.text);
      }
      if (fechaFilterController.text.isNotEmpty) {
        matches &= movimiento.fecha != null &&
            DateFormat('yyyy-MM-dd')
                .format(movimiento.fecha!)
                .contains(fechaFilterController.text);
      }
      if (fechaCompraFilterController.text.isNotEmpty) {
        matches &= movimiento.fechaCompra != null &&
            DateFormat('yyyy-MM-dd')
                .format(movimiento.fechaCompra!)
                .contains(fechaCompraFilterController.text);
      }
      if (cuentaFilterController.text.isNotEmpty) {
        matches &=
            movimiento.cuenta?.contains(cuentaFilterController.text) ?? false;
      }
      if (clienteProveedorFilterController.text.isNotEmpty) {
        matches &= movimiento.clienteProveedor
                ?.contains(clienteProveedorFilterController.text) ??
            false;
      }
      if (numeroFacturaFilterController.text.isNotEmpty) {
        matches &= movimiento.numeroFactura
                ?.contains(numeroFacturaFilterController.text) ??
            false;
      }
      if (numeroCIFilterController.text.isNotEmpty) {
        matches &=
            movimiento.numeroCI?.contains(numeroCIFilterController.text) ??
                false;
      }
      if (descripcionFilterController.text.isNotEmpty) {
        matches &= movimiento.descripcion
                ?.contains(descripcionFilterController.text) ??
            false;
      }
      if (fechaPagoFilterController.text.isNotEmpty) {
        matches &= movimiento.fechaPago != null &&
            DateFormat('yyyy-MM-dd')
                .format(movimiento.fechaPago!)
                .contains(fechaPagoFilterController.text);
      }
      if (ingresoFilterController.text.isNotEmpty) {
        matches &= movimiento.ingreso
                ?.toString()
                .contains(ingresoFilterController.text) ??
            false;
      }
      if (egresoFilterController.text.isNotEmpty) {
        matches &= movimiento.egreso
                ?.toString()
                .contains(egresoFilterController.text) ??
            false;
      }
      if (saldoFilterController.text.isNotEmpty) {
        matches &=
            movimiento.saldo?.toString().contains(saldoFilterController.text) ??
                false;
      }
      if (totalFilterController.text.isNotEmpty) {
        matches &=
            movimiento.total?.toString().contains(totalFilterController.text) ??
                false;
      }
      if (retencionFilterController.text.isNotEmpty) {
        matches &= movimiento.retencion
                ?.toString()
                .contains(retencionFilterController.text) ??
            false;
      }
      if (cuentaInternaController.text.isNotEmpty) {
        matches &= movimiento.cuentaInterna
                ?.contains(cuentaInternaController.text.toUpperCase()) ??
            false;
      }
      return matches;
    }).toList();

    isLoading.value = false;
  }

  void updateMovimiento(MovimientoContable movimiento) async {
    await apiService.updateAccountMove(movimiento);
    fetchData();
  }

  Widget dasboard(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contabilidad'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Filtros', style: TextStyle(fontSize: 20)),
                DataTable(
                  columns: const [
                    // DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Fecha Compra')),
                    DataColumn(label: Text('Cuenta')),
                    DataColumn(label: Text('Cuenta Bancaria')),
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
                  rows: [
                    DataRow(cells: [
                      // DataCell(TextField(
                      //   controller: idFilterController,
                      //   decoration:
                      //       const InputDecoration(hintText: 'ID'),
                      //   onChanged: (value) => fetchData(),
                      // )),
                      DataCell(TextField(
                        controller: fechaFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Fecha Ingreso'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: fechaCompraFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Fecha Compra'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: cuentaInternaController,
                        decoration: const InputDecoration(hintText: 'Cuenta'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: cuentaFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Cuenta Bancaria'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: clienteProveedorFilterController,
                        decoration: const InputDecoration(
                            hintText: 'Cliente/Proveedor'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: numeroFacturaFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Número Factura'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: numeroCIFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Número CI'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: descripcionFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Descripción'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: fechaPagoFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Fecha Pago'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: ingresoFilterController,
                        decoration: const InputDecoration(hintText: 'Ingreso'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: egresoFilterController,
                        decoration: const InputDecoration(hintText: 'Egreso'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: saldoFilterController,
                        decoration: const InputDecoration(hintText: 'Saldo'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: totalFilterController,
                        decoration: const InputDecoration(hintText: 'Total'),
                        onChanged: (value) => fetchData(),
                      )),
                      DataCell(TextField(
                        controller: retencionFilterController,
                        decoration:
                            const InputDecoration(hintText: 'Retención'),
                        onChanged: (value) => fetchData(),
                      )),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Contenidos', style: TextStyle(fontSize: 20)),
                DataTable(
                  columns: const [
                    // DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Fecha Compra')),
                    DataColumn(label: Text('Cuenta')),
                    DataColumn(label: Text('Cuenta Bancaria')),
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
                      // DataCell(SizedBox(
                      //     width: 20, child: Text(movimiento.id.toString()))),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.fecha != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(movimiento.fecha!)
                              : '',
                        ),
                        onSubmitted: (value) {
                          movimiento.fecha =
                              DateFormat('yyyy-MM-dd').parse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.fechaCompra != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(movimiento.fechaCompra!)
                              : '',
                        ),
                        onSubmitted: (value) {
                          movimiento.fechaCompra =
                              DateFormat('yyyy-MM-dd').parse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.cuentaInterna ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.cuentaInterna = value;
                          updateMovimiento(movimiento);
                        },
                      )),
                      // DataCell(TextField(
                      //   controller: TextEditingController(
                      //     text: movimiento.cuenta ?? '',
                      //   ),
                      //   onSubmitted: (value) {
                      //     movimiento.cuenta = value;
                      //     updateMovimiento(movimiento);
                      //   },
                      // )),
                      DataCell(Row(
                        children: [
                          Text(movimiento.cuenta ?? ''),
                          TextButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Transferir a cuenta...'),
                                  content: Obx(() {
                                    return DropdownButton<String>(
                                      isExpanded: true,
                                      hint: const Text(
                                          'Seleccione Cuenta Bancaria'),
                                      value: selectedCuenta.value,
                                      onChanged: (newValue) {
                                        selectedCuenta.value = newValue;
                                      },
                                      items: cuentas.map((cuenta) {
                                        return DropdownMenuItem<String>(
                                          value: cuenta,
                                          child: Text(cuenta),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        movimiento.cuenta =
                                            selectedCuenta.value;
                                        apiService
                                            .updateAccountMove(movimiento);
                                        fetchData();
                                        Get.back();
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.clienteProveedor ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.clienteProveedor = value;
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.numeroFactura ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.numeroFactura = value;
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.numeroCI ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.numeroCI = value;
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.descripcion ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.descripcion = value;
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.fechaPago != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(movimiento.fechaPago!)
                              : '',
                        ),
                        onSubmitted: (value) {
                          movimiento.fechaPago =
                              DateFormat('yyyy-MM-dd').parse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.ingreso?.toString() ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.ingreso = double.tryParse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.egreso?.toString() ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.egreso = double.tryParse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.saldo?.toString() ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.saldo = double.tryParse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.total?.toString() ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.total = double.tryParse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                      DataCell(TextField(
                        controller: TextEditingController(
                          text: movimiento.retencion?.toString() ?? '',
                        ),
                        onSubmitted: (value) {
                          movimiento.retencion = double.tryParse(value);
                          updateMovimiento(movimiento);
                        },
                      )),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
