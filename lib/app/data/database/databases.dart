import 'dart:io' as io;
import 'package:banck_accounts_cards/app/data/models/account_move_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class Databases extends GetxController {
  String dbPath = "";
  late Database database;

  @override
  void onInit() async {
    super.onInit();
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();

    dbPath = p.join(appDocumentsDir.path, "databases", "account_moves.db");
    database = await databaseFactory.openDatabase(
      dbPath,
    );
    await database.execute('''
      CREATE TABLE IF NOT EXISTS account_moves (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fecha TEXT,
      fechaCompra TEXT,
      mesAno TEXT,
      cuentaInterna TEXT,
      cuenta TEXT,
      clienteProveedor TEXT,
      numeroFactura TEXT,
      numeroCI TEXT,
      descripcion TEXT,
      fechaPago TEXT,
      ingreso REAL,
      egreso REAL,
      saldo REAL,
      total REAL,
      retencion REAL
    );
  ''').catchError((error) {
      Get.snackbar('Error', 'Error al crear la base de datos');
    });
  }

  Future<int> insert(MovimientoContable move) async {
    return await database.insert('account_moves', move.toJson());
  }

  Future<List<MovimientoContable>> getMoves(String cuenta) async {
    List<Map<String, dynamic>> maps = await database.query(
      'account_moves',
      where: 'cuenta = ?',
      whereArgs: [cuenta],
    );
    if (maps.isNotEmpty) {
      return maps.map((map) => MovimientoContable.fromJson(map)).toList();
    }
    return [];
  }

  Future<List<MovimientoContable>> getInternalAccount(String cuenta) async {
    List<Map<String, dynamic>> maps = await database.query(
      'account_moves',
      where: 'cuentaInterna = ?',
      whereArgs: [cuenta],
    );
    if (maps.isNotEmpty) {
      return maps.map((map) => MovimientoContable.fromJson(map)).toList();
    }
    return [];
  }

  Future<List<MovimientoContable>> getAllMoves() async {
    List<Map<String, dynamic>> maps = await database.query('account_moves');
    return List.generate(maps.length, (i) {
      return MovimientoContable.fromJson(maps[i]);
    });
  }

  Future<int> updateMove(MovimientoContable move) async {
    return await database.update(
      'account_moves',
      move.toJson(),
      where: 'id = ?',
      whereArgs: [move.id],
    );
  }

  Future<List<String>> getAllClients() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'account_moves',
      columns: ['clienteProveedor'],
      distinct: true,
    );

    return List.generate(maps.length, (i) {
      return maps[i]['clienteProveedor'] as String;
    });
  }

  Future<int> delete(int id) async {
    return await database.delete(
      'account_moves',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getTotalSaldo(String cuenta) async {
    final List<MovimientoContable> movimientos = await getMoves(cuenta);

    double saldoTotal = 0;
    for (var movimiento in movimientos) {
      saldoTotal += (movimiento.ingreso! - movimiento.egreso!);
    }

    return saldoTotal;
  }
}
