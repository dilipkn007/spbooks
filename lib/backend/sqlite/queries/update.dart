import 'package:sqflite/sqflite.dart';

/// BEGIN ADDBOOKMARK
Future performAddBookmark(
  Database database, {
  required int bookId,
  int? chapterId,
  required String type,
}) async {
  await database.rawInsert(
    'INSERT INTO bookmarks (book_id, chapter_id, type) VALUES (?, ?, ?)',
    [bookId, chapterId, type],
  );
}
/// END ADDBOOKMARK

/// BEGIN REMOVEBOOKMARK
Future performRemoveBookmark(
  Database database, {
  required int bookId,
  int? chapterId,
  required String type,
}) async {
  if (chapterId != null) {
    await database.rawDelete(
      'DELETE FROM bookmarks WHERE book_id = ? AND chapter_id = ? AND type = ?',
      [bookId, chapterId, type],
    );
  } else {
    await database.rawDelete(
      'DELETE FROM bookmarks WHERE book_id = ? AND type = ?',
      [bookId, type],
    );
  }
}
/// END REMOVEBOOKMARK