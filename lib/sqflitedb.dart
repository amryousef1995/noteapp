import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await startdb();
      return _db;
    } else {
      return _db;
    }
  }

  startdb() async {
    var dbpath = await getDatabasesPath();
    var path = join(dbpath, "amr.db");
    Database mydb = await openDatabase(path,
        version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return mydb;
  }

  // ignore: unused_element
  _onUpgrade(Database db, int oldversion, int newversion) async {
    await db.execute("ALTER TABLE notes ADD COLUMN color  TEXT");
    // ignore: avoid_print
    print("Updrade+++++++++++++++++++++++++");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" TEXT NOT NULL
  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase(String sql) async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'amr.db');
    await deleteDatabase(path);
  }

  readData2(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insertData2(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  updateData2(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData2(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
