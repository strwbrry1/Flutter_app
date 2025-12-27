import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'app.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE likes (
            card_id TEXT PRIMARY KEY
          )
        ''');
      },
    );
    return _db!;
  }
}
