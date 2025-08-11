import 'package:medical_store/SupplierScreenModel.dart';
import 'package:medical_store/databaseprovider.dart';
import 'package:sqflite/sqlite_api.dart';

class SupplierDao {
  Future<void> insertsupplier(Supplierscreenmodel Supplierscreenmodel) async {
    var db = await DatabaseProvider().db;
    await db!.insert(
      "SupplierScreenModel",
      Supplierscreenmodel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Supplierscreenmodel>> getsupplier() async {
    var db = await DatabaseProvider().db;
    final List<Map<String, dynamic>> maps = await db!.query(
      "SupplierScreenModel",
    );
    return List.generate(maps.length, (i) {
      return Supplierscreenmodel.fromMap(maps[i]);
    });
  }

  Future<void> updatesupplier(Supplierscreenmodel Supplierscreenmodel) async {
    var db = await DatabaseProvider().db;
    await db!.update(
      "SupplierScreenModel",
      Supplierscreenmodel.toMap(),
      where: "id=?",
      whereArgs: [Supplierscreenmodel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletsupplier(int id) async {
    var db = await DatabaseProvider().db;
    await db!.delete("Supplierscreenmodel", where: "id=?", whereArgs: [id]);
  }
}
