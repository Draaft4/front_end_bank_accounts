import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:banck_accounts_cards/app/data/services/services.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_transaction_form.dart';
import 'package:banck_accounts_cards/app/ui/pages/exporter_page/exporter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DinersAccountPage {
  final ApiServiceOnAccount apiService = Get.find<ApiServiceOnAccount>();
  RxList<MovimientoContable> movimientos = <MovimientoContable>[].obs;
  RxBool isLoading = false.obs;

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
  final TextEditingController ingresoFilterController = TextEditingController();
  final TextEditingController egresoFilterController = TextEditingController();
  final TextEditingController saldoFilterController = TextEditingController();
  final TextEditingController totalFilterController = TextEditingController();
  final TextEditingController retencionFilterController =
      TextEditingController();

  final TextEditingController cuentaInternaController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // Variables para el estado de ordenamiento
  int? _sortColumnIndex;
  bool _isAscending = true;

  void fetchData() async {
    isLoading.value = true;
    List<MovimientoContable> allMovimientos =
        (await apiService.fetchData("Diners")).cast<MovimientoContable>();
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
        title: const Text('Cuenta Diners Club'),
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
                  arguments: {'account_origin': 'Diners'});
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
              Get.to(() => ExporterPage(),
                  arguments: {'account_origin': 'Diners'});
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
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Fecha Compra')),
                    DataColumn(label: Text('Cuenta')),
                    DataColumn(label: Text('Cliente/Proveedor')),
                    DataColumn(label: Text('Número Factura')),
                    DataColumn(label: Text('Número CI')),
                    DataColumn(label: Text('Descripción')),
                    DataColumn(label: Text('Ingreso')),
                    DataColumn(label: Text('Egreso')),
                    DataColumn(label: Text('Saldo')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Retención')),
                  ],
                  rows: [
                    DataRow(cells: [
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
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _isAscending,
                  columns: [
                    DataColumn(
                      label: const Text('Fecha'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.fecha, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Fecha Compra'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.fechaCompra, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Cuenta'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.cuentaInterna, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Cliente/Proveedor'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.clienteProveedor, columnIndex,
                            ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Número Factura'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.numeroFactura, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Número CI'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.numeroCI, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Descripción'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.descripcion, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Ingreso'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.ingreso, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Egreso'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.egreso, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Saldo'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.saldo, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Total'),
                      onSort: (columnIndex, ascending) {
                        _sortData((mov) => mov.total, columnIndex, ascending);
                      },
                    ),
                    DataColumn(
                      label: const Text('Retención'),
                      onSort: (columnIndex, ascending) {
                        _sortData(
                            (mov) => mov.retencion, columnIndex, ascending);
                      },
                    ),
                  ],
                  rows: movimientos.map((movimiento) {
                    return DataRow(cells: [
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

  // Método para ordenar los datos
  void _sortData<T>(Comparable<T>? Function(MovimientoContable mov) getField,
      int columnIndex, bool ascending) {
    movimientos.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue as Comparable, bValue as Comparable)
          : Comparable.compare(bValue as Comparable, aValue as Comparable);
    });
    _sortColumnIndex = columnIndex;
    _isAscending = ascending;
  }
}
