import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../data/services/services.dart';
import '../data/models/account_move_model.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

class ExporterController extends GetxController {
  final ApiServiceOnAccount apiService = Get.find<ApiServiceOnAccount>();
  final ApiServiceAccounting apiServiceAccounting =
      Get.find<ApiServiceAccounting>();
  List<MovimientoContable> data = [];

  var items = [
    'Efectivo',
    'AP221',
    'E210',
    'P348',
    'C092',
    'Diners',
    'J406',
    'GENERAL'
  ].obs;
  var selectedItem = RxnString();

  void setSelectedItem(String? value) {
    selectedItem.value = value;
  }

  Future<void> exportToExcel() async {
    if (selectedItem.value == null) {
      Get.snackbar('Error', 'No directory selected');
      return;
    }
    if (selectedItem.value == 'GENERAL') {
      data =
          (await apiServiceAccounting.fetchData()).cast<MovimientoContable>();
    } else {
      data = (await apiService.fetchData(selectedItem.value!))
          .cast<MovimientoContable>();
    }

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add header row
    sheetObject.appendRow([
      TextCellValue('ID'),
      TextCellValue('Fecha'),
      TextCellValue('Fecha Compra'),
      // TextCellValue('Mes/Año'),
      TextCellValue('Cuenta'),
      TextCellValue('Cuenta Bancaria'),
      TextCellValue('Cliente/Proveedor'),
      TextCellValue('Número Factura'),
      TextCellValue('Número CI'),
      TextCellValue('Descripción'),
      TextCellValue('Fecha Pago'),
      TextCellValue('Ingreso'),
      TextCellValue('Egreso'),
      TextCellValue('Saldo'),
      TextCellValue('Total'),
      TextCellValue('Retención')
    ]);

    // Add data rows
    for (var item in data) {
      sheetObject.appendRow([
        TextCellValue(item.id.toString()),
        TextCellValue(item.fecha!.toIso8601String()),
        TextCellValue(item.fechaCompra!.toIso8601String()),
        // TextCellValue(item.mesAno.toString()),
        TextCellValue(item.cuentaInterna.toString()),
        TextCellValue(item.cuenta.toString()),
        TextCellValue(item.clienteProveedor.toString()),
        TextCellValue(item.numeroFactura.toString()),
        TextCellValue(item.numeroCI.toString()),
        TextCellValue(item.descripcion.toString()),
        TextCellValue(item.fechaPago!.toIso8601String()),
        TextCellValue(item.ingreso.toString()),
        TextCellValue(item.egreso.toString()),
        TextCellValue(item.saldo.toString()),
        TextCellValue(item.total.toString()),
        TextCellValue(item.retencion.toString()),
      ]);
    }

    // Save the file
    final directory = await getAplicationDocumentsDirectory();
    if (directory != 'No se ha seleccionado un directorio.') {
      String filePath = '$directory/${selectedItem.value!}.xlsx';
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      Get.back();
      Get.snackbar('Success', 'Archivo de Excel guardado en: $filePath');
    } else {
      Get.back();
      Get.snackbar('Error', 'No se ha seleccionado un directorio.');
    }
  }

  Future<String> getAplicationDocumentsDirectory() async {
    final file = DirectoryPicker()..title = 'Seleccione un directorio';
    final Directory? result = file.getDirectory();
    if (result != null) {
      return result.path;
    } else {
      return 'No se ha seleccionado un directorio.';
    }
  }
}
