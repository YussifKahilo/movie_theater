import 'package:sqflite/sqflite.dart';

class SqlTables {
  static const String moviesTable = "movies";

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $moviesTable (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        backdrop_path TEXT NOT NULL,
        poster_path TEXT NOT NULL,
        overview TEXT NOT NULL,
        release_date TEXT NOT NULL,
        vote_count INTEGER NOT NULL,
        vote_average NUMBER NOT NULL,
        movie_section INTEGER NOT NULL,
      )
    ''');
  }
}
