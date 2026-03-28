import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

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

  Future<List<FetchBookmarkedBooksRow>> fetchBookmarkedBooks() =>
      performFetchBookmarkedBooks(
        _database,
      );

  Future<List<FetchBookmarkedPagesRow>> fetchBookmarkedPages() =>
      performFetchBookmarkedPages(
        _database,
      );

  Future<List<FetchReadingHistoryRow>> fetchReadingHistory() =>
      performFetchReadingHistory(
        _database,
      );

  /// START UPDATE QUERY CALLS

  Future addBookmark({
    required int bookId,
    int? chapterId,
    required String type,
  }) =>
      performAddBookmark(
        _database,
        bookId: bookId,
        chapterId: chapterId,
        type: type,
      );

  Future removeBookmark({
    required int bookId,
    int? chapterId,
    required String type,
  }) =>
      performRemoveBookmark(
        _database,
        bookId: bookId,
        chapterId: chapterId,
        type: type,
      );

  Future updateReadingHistory({
    required int bookId,
    int? chapterId,
    required double percent,
  }) =>
      performUpdateReadingHistory(
        _database,
        bookId: bookId,
        chapterId: chapterId,
        percent: percent,
      );

  /// END UPDATE QUERY CALLS
}
