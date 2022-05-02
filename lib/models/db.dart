import 'package:diligencias/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDBProvider {
  static final UserDBProvider db = UserDBProvider();
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
              "CREATE TABLE IF NOT EXISTS user(oidUsuario INTEGER PRIMARY KEY , oidTusuario TEXT,empresa TEXT,nombreEmpresa TEXT, oidEmpresa TEXT, ciudad TEXT, oidCiudad TEXT, oidOficina TEXT, oidSeccion TEXT, ultimaEntrada TEXT, nombreCiudad TEXT, nombreOficina TEXT, taquilla TEXT, oidUbicacion TEXT); SHOW DATABASES; DROP DATABASE IF EXISTS user;");
        });

  }


  Future<int> addToDatabase(User my) async {
    final db = await database;
    var a = db.insert("user", my.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return a;
  }

  Future<int> updateWish(User my) async {
    final db = await database;
    var response = db.update('user', my.toMap(),
        where: 'oidUsuario = ?', whereArgs: [my.oidUsuario]);
    return response;
  }

  Future<List<User>> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM user ORDER BY ultimaEntrada DESC");
    List<User> list = maps.isNotEmpty
        ? maps.map((note) => User.fromJsonDB(note)).toList()
        : [];
    print("aquui ${list} ${maps[0]['ubicacion']["ultimaEntrada"]}");
    return list;
  }
}
