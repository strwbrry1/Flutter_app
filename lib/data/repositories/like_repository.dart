import 'package:sqflite/sqflite.dart';

import '../database/app_database.dart';

class LikeRepository {
  Future<List<String>> loadLikes() async {
    final db = await AppDatabase.instance;
    final result = await db.query('likes');

    return result.map((e) => e['card_id'] as String).toList();
  }

  Future<void> toggleLike(String id) async {
    final db = await AppDatabase.instance;

    final exists = await db.query(
      'likes',
      where: 'card_id = ?',
      whereArgs: [id],
    );

    if (exists.isNotEmpty) {
      await db.delete(
        'likes',
        where: 'card_id = ?',
        whereArgs: [id],
      );
    } else {
      await db.insert(
        'likes',
        {'card_id': id},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}
