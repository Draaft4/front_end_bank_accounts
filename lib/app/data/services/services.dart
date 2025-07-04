import 'package:banck_accounts_cards/app/data/database/databases.dart';
import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:get/get.dart';

class BaseApiService extends GetConnect {
  Databases databases = Get.find<Databases>();
}

class ApiServiceAccounting extends BaseApiService {
  Future<List> fetchData() async {
    return databases.getAllMoves();
  }

  Future<Future<int>> createAccountMove(MovimientoContable accountMove) async {
    return databases.insert(accountMove);
  }

  Future<double> getBalance(String cuenta) async {
    return databases.getTotalSaldo(cuenta);
  }

  Future<void> updateAccountMove(MovimientoContable accountMove) async {
    await databases.updateMove(accountMove);
  }

  Future<double> getRetention(String cuenta) async {
    final List<MovimientoContable> movimientos =
        await databases.getMoves(cuenta);

    double totalRetencion = 0;
    for (var movimiento in movimientos) {
      totalRetencion += movimiento.retencion ?? 0;
    }

    return totalRetencion;
  }
}

class ApiServiceOnAccount extends BaseApiService {
  Future<List> fetchData(String account) async {
    return databases.getMoves(account);
  }

  Future<List> fetchPersonalAccounts(String account) async {
    return databases.getPersonalAccounts(account);
  }

  Future<List> fetchDataInternal(String account) async {
    return databases.getInternalAccount(account);
  }

  Future<void> updateAccountMove(MovimientoContable accountMove) async {
    await databases.updateMove(accountMove);
  }
}
