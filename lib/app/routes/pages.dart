import 'package:banck_accounts_cards/app/bindings/account_move_form_binding.dart';
import 'package:banck_accounts_cards/app/bindings/home_binding.dart';
import 'package:banck_accounts_cards/app/bindings/splash_binding.dart';
import 'package:banck_accounts_cards/app/routes/routes.dart';
import 'package:banck_accounts_cards/app/ui/forms/account_move_form.dart';
import 'package:banck_accounts_cards/app/ui/pages/home_page/home_page.dart';
import 'package:banck_accounts_cards/app/ui/pages/splash_page/splash_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.FORM,
      page: () => AccountMoveForm(),
      binding: AccountMoveFormBinding(),
    ),
  ];
}
