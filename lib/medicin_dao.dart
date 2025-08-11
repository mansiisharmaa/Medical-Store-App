import 'package:medical_store/databaseprovider.dart';
import 'package:medical_store/MedicineModel.dart';
import 'package:sqflite/sqlite_api.dart';

class MedicinDao {
  Future<void>insertmedicin(MedicineModel medicinmodel)async{
    var db=await DatabaseProvider().db;
    await db!.insert(
     
      "medicinmodel",
      medicinmodel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }
  Future<List<MedicineModel>>getmedicin()async{
    
    var db = await DatabaseProvider().db;
    final List<Map<String ,dynamic>> maps = await db!.query("medicinmodel");
    return List.generate(maps.length,(i){
      return MedicineModel.fromMap(maps[i]);

    });
  }
   Future<void>updateMedicin(MedicineModel medicinmodel)async{
    var db=await DatabaseProvider().db;
    await db!.update(

      "medicinmodel",
      medicinmodel.toMap(),
      where: "id=?",
      whereArgs: [medicinmodel.id],
     conflictAlgorithm:ConflictAlgorithm.replace,
    );
  }

   Future<void>deletMedicin(int id)async{
    var db=await DatabaseProvider().db;
    await db!.delete("medicinmodel",
    where: "id=?",
    whereArgs: [id]);
  }
}