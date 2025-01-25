import 'package:banck_accounts_cards/app/controllers/account_move_form_controller.dart';
import 'package:get/get.dart';

class AccountMoveFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountMoveFormController>(() => AccountMoveFormController());
  }
}
