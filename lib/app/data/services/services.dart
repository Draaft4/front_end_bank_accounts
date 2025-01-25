import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:get/get.dart';

class BaseApiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    baseUrl = "http://localhost:8080/api";
  }
}

class ApiServiceAccounting extends BaseApiService {
  Future<List> fetchData() async {
    final Response<List<dynamic>> response = await get<List<dynamic>>(
      '',
      decoder: (data) {
        return (data as List)
            .map((item) => MovimientoContable.fromJson(item))
            .toList();
      },
    );
    return response.body ?? [];
  }

  Future<Response> createAccountMove(MovimientoContable accountMove) async {
    final response = await post(
      '/ingreso',
      accountMove.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  Future<Response> getBalanceAP221() async {
    final response = await get('/AP221/saldo');
    return response;
  }

  Future<Response> getBalanceE210() async {
    final response = await get('/E210/saldo');
    return response;
  }

  Future<Response> getBalanceP348() async {
    final response = await get('/P348/saldo');
    return response;
  }

  Future<Response> getBalanceDiners() async {
    final response = await get('/Diners/saldo');
    return response;
  }

  Future<Response> getBalanceJ406() async {
    final response = await get('/J406/saldo');
    return response;
  }

  Future<Response> getBalanceC092() async {
    final response = await get('/C092/saldo');
    return response;
  }
}

class ApiServiceOnAccount extends BaseApiService {
  Future<List> fetchData(String account) async {
    final Response<List<dynamic>> response = await get<List<dynamic>>(
      '/$account/movimientos',
      decoder: (data) {
        if (data is List) {
          return (data)
              .map((item) => MovimientoContable.fromJson(item))
              .toList();
        } else {
          return [];
        }
      },
    );
    return response.body ?? [];
  }
}
