import 'package:banck_accounts_cards/app/controllers/exporter_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import necesario para formatear fechas

class ExporterPage extends GetView<ExporterController> {
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final accountOrigin = args['account_origin'];
    if (accountOrigin != null) {
      controller.setSelectedItem(accountOrigin);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar a Excel...'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return DropdownButton<String>(
                hint: const Text('Seleccionar'),
                value: controller.selectedItem.value,
                onChanged: (String? newValue) {
                  controller.setSelectedItem(newValue);
                },
                items: controller.items
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        controller.setStartDate(pickedDate);
                      }
                    },
                    child: Text(controller.startDate.value != null
                        ? 'Desde: ${DateFormat('yyyy-MM-dd').format(controller.startDate.value!)}'
                        : 'Seleccionar Fecha Inicial'),
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        controller.setEndDate(pickedDate);
                      }
                    },
                    child: Text(controller.endDate.value != null
                        ? 'Hasta: ${DateFormat('yyyy-MM-dd').format(controller.endDate.value!)}'
                        : 'Seleccionar Fecha Final'),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                controller.exportToExcel();
              },
              child: const Text('Exportar'),
            ),
          ],
        ),
      ),
    );
  }
}
