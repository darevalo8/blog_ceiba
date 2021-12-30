import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
//import 'package:global_configuration/global_configuration.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  initDB() async {
    String documentsDirectory = await getDatabasesPath();
    //   print(documentsDirectory);
    String path = join(documentsDirectory, 'heart_rate.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {


    await db.execute('''CREATE TABLE user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(60), username VARCHAR(60), email VARCHAR(60),
    phone VARCHAR(60), website VARCHAR(60));
    ''');

    await db.execute('''CREATE TABLE post(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(100), body VARCHAR(300), userId INTEGER,
    FOREIGN KEY(userId) REFERENCES user(id)
    );
    ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await database;
    return await db!.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> selectQuery(
      String table, String columnId, String id) async {
    final db = await database;
    final response =
        await db!.query(table, where: '$columnId = ?', whereArgs: [id]);
    return response;
  }

  Future<List<Map<String, dynamic>>> likeQuery(
      String table, String columnId, String id) async {
    final db = await database;
    final response =
        await db!.query(table, where: '$columnId like ?', whereArgs: [id]);
    return response;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount(String table) async {
  //   final db = await database;
  //   return Sqflite.firstIntValue(
  //       await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  // }
  Future<List<Map<String, dynamic>>> selectFirstFive(String table) async {
    final db = await database;
    return await db!.rawQuery('SELECT * FROM $table order by fecha limit 5');
  }
  Future<List<Map<String, dynamic>>> selectOrderAll(String table) async {
    final db = await database;
    return await db!.rawQuery('SELECT * FROM $table');
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(
      String table, String columnId, Map<String, dynamic> row) async {
    final db = await database;
    final id = row[columnId];
    return await db!
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, String columnId, String id) async {
    final db = await database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll(String table) async {
    final db = await database;
    return await db!.delete(table);
  }
}