import 'dart:io';

import 'package:flutter/services.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabaseFromDbFile(
  String databaseName,
  String databaseAssetFilename,
) async {
  final databasesPath = await getDatabasesPath();
  final path = '$databaseName.db';
  final databasePath = join(databasesPath, path);
  // First, check if the database exists.
  final exists = await databaseExists(databasePath);
  if (!exists) {
    // Ensure parent directory exists.
    try {
      await Directory(dirname(databasePath)).create(recursive: true);
    } catch (_) {}
    // Copy the database file over to the working database directory.
    final databaseData = await rootBundle
        .load(join('assets', 'sqlite_db_files', databaseAssetFilename));
    final databaseBytes = databaseData.buffer.asUint8List(
      databaseData.offsetInBytes,
      databaseData.lengthInBytes,
    );
    await File(databasePath).writeAsBytes(databaseBytes, flush: true);
  }
  // Initialize the SQLite database.
  final database = await openDatabase(databasePath);
  await database.execute('''
    CREATE TABLE IF NOT EXISTS bookmarks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      book_id INTEGER NOT NULL,
      chapter_id INTEGER,
      type TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  ''');
  await database.execute('''
    CREATE TABLE IF NOT EXISTS reading_history (
      book_id INTEGER PRIMARY KEY,
      chapter_id INTEGER,
      percent REAL NOT NULL DEFAULT 0,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  ''');
  return database;
}
