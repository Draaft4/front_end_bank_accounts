import 'package:banck_accounts_cards/app/controllers/exporter_controller.dart';
import 'package:get/get.dart';

class ExporterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExporterController>(() => ExporterController());
  }
}
