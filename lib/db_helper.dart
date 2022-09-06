import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databasename = 'persons.db';
  static const _databaseversion = 1;
  static const table = 'my_table';

  static const columnID = 'id';
  static const columnName = 'name';
  static const columnage = 'age';

  static Database? _database;

  // must: This will allow us to give only a single
  // instence to work instead of giving a new instence everytime when we create object
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instence = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreateDatabase);
  }

  Future _onCreateDatabase(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table(
  $columnID INTEGER PRIMARY KEY,
  $columnName TEXT NOT NULL,
  $columnage INTEGER NOT NULL
)
      ''');
  }

  // Function to insert, query, update and delete
  // insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instence.database;
    return await db!.insert(table, row);
  }

  // Query / all rows
  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instence.database;
    return await db!.query(table);
  }

  // Query Specific
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database? db = await instence.database;
    // var result = await db!.query(table, where: "age> ?", whereArgs: [age]);
    var result =
        await db!.rawQuery("SELECT * FROM $table WHERE age > ?", [age]);
    return result;
  }

  // Delete
  Future<int> deleteData(int id) async {
    Database? db = await instence.database;
    var deletedId = await db!.delete(table, where: "id = ?", whereArgs: [id]);
    return deletedId;
  }

  // update
  Future<int> update(int id) async {
    Database? db = await instence.database;
    var result = await db!.update(table, {"name": "qwerty", "age": 2},
        where: "id = ?", whereArgs: [id]);
    return result;
  }
}
