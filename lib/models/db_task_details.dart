import 'package:diligencias/models/datos.dart';
import 'package:diligencias/models/task_details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDetailsDBProvider {
  static final TaskDetailsDBProvider db = TaskDetailsDBProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDb();
    return _database!;
  }

  Future openDb() async {
    return await openDatabase(join(await getDatabasesPath(), "my.db"),
        version: 1,
        onOpen: (db) async {}, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS taskdetails(ciudad INTEGER PRIMARY KEY , tipo TEXT, remitente TEXT, contacto TEXT, telefono TEXT, direccion TEXT, nciudad TEXT); SHOW DATABASES; DROP DATABASE IF EXISTS datos;");
        });
  }

  Future<int> addToDatabaseTask(TaskDetails my) async {
    final db = await database;
    var a = db.insert("taskdetails", my.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return a;
  }

  Future<int> updateWish(TaskDetails my) async {
    final db = await database;
    var response = db.update('taskdetails', my.toMap(),
        where: 'ciudad = ?', whereArgs: [my.ciudad]);
    return response;
  }

  Future<List<TaskDetails>> getTaskDetails() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM taskdetails ORDER BY nciudad DESC");
    List<TaskDetails> list = maps.isNotEmpty
        ? maps.map((note) => TaskDetails.fromJsonDB(note)).toList()
        : [];
    print("aquui ${list} ${maps[0]["nciudad"]}");
    return list;
  }
}
