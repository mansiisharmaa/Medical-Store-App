import 'package:medical_store/supplierOrderTable.dart';
import 'package:sqflite/sqflite.dart';

import 'databaseprovider.dart';

class SupplierordertableDao {
  Future<int> insertsupplier(Supplierordertable supplierordertable) async {
    var db = await DatabaseProvider().db;
    int orderId = await db!.insert(
      "supplierOrderTable",
      supplierordertable.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return orderId;
  }

  Future<List<Supplierordertable>> getmedicin() async {
    var db = await DatabaseProvider().db;
    final List<Map<String, dynamic>> maps = await db!.query(
      "supplierOrderTable",
    );
    return List.generate(maps.length, (i) {
      return Supplierordertable.fromMap(maps[i]);
    });
  }

  Future<void> updatesupplier(Supplierordertable supplierOrderTable) async {
    var db = await DatabaseProvider().db;
    await db!.update(
      "supplierOrderTable",
      supplierOrderTable.toMap(),
      where: "id=?",
      whereArgs: [supplierOrderTable.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletsupplier(int id) async {
    var db = await DatabaseProvider().db;
    await db!.delete("supplierOrderTable", where: "id=?", whereArgs: [id]);
  }


  
}
