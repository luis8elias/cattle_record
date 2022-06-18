import 'dart:io';
import 'package:cattle_record/models/animal.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBManager {

  static late Database? _database;

  static final DBManager db = DBManager._internal();

  DBManager._internal();

  Future<Database?> get database async{
    _database = await initDB();
    return _database;
  }
    
  

  initDB() async{

    Directory documentsDir = await getApplicationDocumentsDirectory();

    final path = p.join(documentsDir.path , 'AnimalsRecordsDb.db' );

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async{
          await db.execute(
            'CREATE TABLE records ('
            'id INTEGER PRIMARY KEY, '
            'label TEXT,'
            'sex INTEGER,'
            'age TEXT,'
            'category TEXT,'
            'annotations TEXT'
          ')'
        );
      },
    );
  }


  Future<int> create ({required Animal animal})async{
    final db = await database;
    final res = db!.insert('records', animal.toJson());
    return res;
  }
 
 
  Future<List<Animal>> getAll() async{

    final db = await database;
    final res  = await db!.rawQuery("SELECT * FROM records ORDER BY id DESC" );
    List<Animal> list = res.isNotEmpty ? res.map((element) => Animal.fromJson(element)).toList() : [];
    return list;

  }

  Future<int> delete ({required int id}) async{

    final  db = await database;
    final res = await db!.delete('records', where: 'id = ?' , whereArgs: [id]);
    return res ;

  }
 
  Future<int> deleteAll ( ) async{
    final  db = await database;
    final res = await db!.delete('records');
    return res ;
  }



}