import 'package:banck_accounts_cards/app/controllers/exporter_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
