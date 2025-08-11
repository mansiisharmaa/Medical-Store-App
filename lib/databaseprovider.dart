import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  final String _databaseName = "StudentData.db";
  static Database? _database;

  Future<Database> createDatabase() async {
    if (kIsWeb) {
      var databaseFactory = databaseFactoryFfiWeb;
      return databaseFactory.openDatabase(
        _databaseName,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await _createTables(db);
          },
        ),
      );
    } else {
      String path = join(await getDatabasesPath(), _databaseName);
      return openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await _createTables(db);
        },
      );
    }
  }

  Future<void> _createTables(Database db) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS medicinmodel(id INTEGER PRIMARY KEY AUTOINCREMENT, orderId INTEGER, medicinname TEXT, Discription REAL, quantity TEXT, price REAL)',
    );

    await db.execute(
      'CREATE TABLE IF NOT EXISTS SupplierScreenModel(id INTEGER PRIMARY KEY AUTOINCREMENT, suppliername TEXT,agency TEXT,contactNo TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS supplierOrderTable(id INTEGER PRIMARY KEY AUTOINCREMENT, orderId INTEGER, suppliername TEXT,agencyName Text, contact Text, totalPrice REAL, dateTime TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS orderItemModel(id INTEGER PRIMARY KEY AUTOINCREMENT, orderId INTEGER, medicinname TEXT, discription TEXT, quantity INTEGER, price REAL, date String)',
    );
  }

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }
}
