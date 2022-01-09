import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:portfolio/src/projet.dart';
import 'package:sqflite/sqflite.dart';

class BDD{

  BDD._();
  static final BDD instance = BDD._();
  static Database? _database;

  Future<Database?> get database async {
    if(_database != null){
      return _database;
    }else{
      _database = await _initDB();
      return  _database;
    }
  }

  Future<int?> get countProjects async {
    final Database? db = await database;
    WidgetsFlutterBinding.ensureInitialized();
    if(_database != null){
      return Sqflite.firstIntValue(await _database!.rawQuery("SELECT COUNT(*) FROM projets;"));
    }else {
      return -1;
    }
  }


  _initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(),"ressourcesProjets.db"),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE projets (path TEXT, name TEXT PRIMARY KEY, categorie TEXT, date TEXT, color TEXT, description TEXT, liens Text);"
        );

      },
      version: 1,
    );

  }

  void insertProject(Projet p) async {
    final Database? db = await database;

    await db!.insert(
      "projets",
      p.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateProject(Projet p) async {
    final Database? db = await database;

    await db!.update(
      "projets",
      p.toMap(),
      where: "name = ?",
      whereArgs: [p.name]
    );
  }

  void deleteProject(String name) async {
    final Database? db = await database;

    db!.delete(
      "projets",
       where: "name = ?",
       whereArgs: [name]
    );
  }

  void deleteAllProjects() async {
    final Database? db = await database;

    db!.delete(
        "projets",
    );
  }

  Future<List<Projet>> getAllProjects() async {
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query("projets");

    List<Projet> lp = List.generate(
        maps.length,
        (i){
          return Projet.fromMap(maps[i]);
        }
    );

    if(lp.isEmpty){
    }
    return lp;
  }
}