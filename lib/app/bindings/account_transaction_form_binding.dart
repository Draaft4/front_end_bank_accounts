import 'package:banck_accounts_cards/app/controllers/account_transaction_form_controller.dart';
import 'package:get/get.dart';

class AccountTransactionFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountTransactionFormController>(
        () => AccountTransactionFormController());
  }
}
