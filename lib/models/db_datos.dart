import 'package:diligencias/models/datos.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatosDBProvider {
  static final DatosDBProvider db = DatosDBProvider();
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
              "CREATE TABLE IF NOT EXISTS datos(oid INTEGER PRIMARY KEY , diligencia TEXT,tipo TEXT,destinatario TEXT, contacto TEXT, direccion TEXT, nota TEXT, estado TEXT); SHOW DATABASES; DROP DATABASE IF EXISTS datos;");
        });

  }


  Future<int> addToDatabase(Datos my) async {
    final db = await database;
    var a = db.insert("datos", my.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return a;
  }

  Future<int> updateWish(Datos my) async {
    final db = await database;
    var response = db.update('datos', my.toMap(),
        where: 'oid = ?', whereArgs: [my.oid]);
    return response;
  }

  Future<List<Datos>> getDatos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM datos ORDER BY direccion DESC");
    List<Datos> list = maps.isNotEmpty
        ? maps.map((note) => Datos.fromJsonDB(note)).toList()
        : [];
    print("aquui ${list} ${maps[0]['ubicacion']["ultimaEntrada"]}");
    return list;
  }
}
