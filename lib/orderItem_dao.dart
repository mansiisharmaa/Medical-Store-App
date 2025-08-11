import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/supplierOrderTable.dart';
import 'package:sqflite/sqflite.dart';

import 'databaseprovider.dart';

class OrderitemDao {
  Future<void> insertitem(Orderitemmodel oderitemmodel) async {
    var db = await DatabaseProvider().db;
    await db!.insert(
      "Orderitemmodel",
      oderitemmodel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Orderitemmodel>> getitem() async {
    var db = await DatabaseProvider().db;
    final List<Map<String, dynamic>> maps = await db!.query("Orderitemmodel");
    return List.generate(maps.length, (i) {
      return Orderitemmodel.fromMap(maps[i]);
    });
  }

  Future<void> updateItem(Orderitemmodel orderItemModel) async {
    var db = await DatabaseProvider().db;
    await db!.update(
      "orderItemModel",
      orderItemModel.toMap(),
      where: "id=?",
      whereArgs: [orderItemModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteItem(int id) async {
    var db = await DatabaseProvider().db;
    await db!.delete("oredrItemModel", where: "id=?", whereArgs: [id]);
  }

  Future<List<Orderitemmodel>> getList(int? id) async {
    var db = await DatabaseProvider().db;

      final List<Map<String, dynamic>> maps = await db!.query("orderItemModel",
      where: "orderId=?",
       whereArgs: [id]);
      return List.generate(maps.length, (i){
            return Orderitemmodel.fromMap(maps[i]);
      });
    

  }
}
