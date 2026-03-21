import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'spbooks',
      'spbooksfile.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<ReadAllBooksNamesRow>> readAllBooksNames() =>
      performReadAllBooksNames(
        _database,
      );

  Future<List<FetchChaptersRow>> fetchChapters({
    int? bookId,
    int? parentId,
  }) =>
      performFetchChapters(
        _database,
        bookId: bookId,
        parentId: parentId,
      );

  Future<List<FetchChaptersContentRow>> fetchChaptersContent({
    int? bookId,
    int? parentId,
  }) =>
      performFetchChaptersContent(
        _database,
        bookId: bookId,
        parentId: parentId,
      );

  Future<List<FetchSubChaptersRow>> fetchSubChapters({
    int? chapterId,
    int? bookId,
  }) =>
      performFetchSubChapters(
        _database,
        chapterId: chapterId,
        bookId: bookId,
      );

  Future<List<SearchContentRow>> searchContent({
    int? bookId,
    int? chapterId,
    String? content,
  }) =>
      performSearchContent(
        _database,
        bookId: bookId,
        chapterId: chapterId,
        content: content,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  /// END UPDATE QUERY CALLS
}
