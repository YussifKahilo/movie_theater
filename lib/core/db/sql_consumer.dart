import 'package:movie_theater/core/db/db_consumer.dart';
import 'package:movie_theater/core/db/tables.dart';
import 'package:sqflite/sqflite.dart';

class SQLConsumer implements DBConsumer {
  final String dbName;

  SQLConsumer(this.dbName);

  Future<Database> get database async {
    return openDatabase(
      dbName, //db name
      version: 1, //version number
      onCreate: (Database db, int version) async {
        await SqlTables.createTables(db);
      },
    );
  }

  @override
  Future<void> addData(
      {required Map<String, dynamic> row, required String table}) async {
    final db = await database;
    await db.insert(table, row);
  }

  @override
  Future<void> deleteData({String? where, required String table}) async {
    final db = await database;
    await db.delete(table, where: where);
  }

  @override
  Future<List<Map<String, dynamic>>> getData(
      {String? where, required String table}) async {
    final db = await database;
    return await db.query(table, where: where);
  }

  @override
  Future<void> updateData(
      {required Map<String, dynamic> row,
      String? where,
      required String table}) async {
    final db = await database;
    await db.update(table, row, where: where);
  }
}
