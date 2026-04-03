import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN READ ALL BOOKS NAMES
Future<List<ReadAllBooksNamesRow>> performReadAllBooksNames(
  Database database,
) {
  final query = '''
select*from books;
''';
  return _readQuery(database, query, (d) => ReadAllBooksNamesRow(d));
}

class ReadAllBooksNamesRow extends SqliteRow {
  ReadAllBooksNamesRow(Map<String, dynamic> data) : super(data);

  String? get title => data['title'] as String?;
  int? get id => data['id'] as int?;
  String? get author => data['author'] as String?;
  String? get language => data['language'] as String?;
  String? get description => data['description'] as String?;
  String? get cover => (data['cover'] as String?)?.trim();
}

/// END READ ALL BOOKS NAMES

/// BEGIN FETCHCHAPTERS
Future<List<FetchChaptersRow>> performFetchChapters(
  Database database, {
  int? bookId,
  int? parentId,
}) {
  final query = '''
SELECT * FROM chapters WHERE book_id = ${bookId} AND parent_id=${parentId} ORDER BY number;
''';
  return _readQuery(database, query, (d) => FetchChaptersRow(d));
}

class FetchChaptersRow extends SqliteRow {
  FetchChaptersRow(Map<String, dynamic> data) : super(data);

  String get title => data['title'] as String;
  String get content => data['content'] as String;
  int get number => data['number'] as int;
  int get bookId => data['book_id'] as int;
  int get id => data['id'] as int;
  int get parentId => data['parent_id'] as int;
}

/// END FETCHCHAPTERS

/// BEGIN FETCHCHAPTERSCONTENT
Future<List<FetchChaptersContentRow>> performFetchChaptersContent(
  Database database, {
  int? bookId,
  int? parentId,
}) {
  final query = '''
SELECT * FROM chapters WHERE book_id = ${bookId} AND parent_id=${parentId} ORDER BY number;
''';
  return _readQuery(database, query, (d) => FetchChaptersContentRow(d));
}

class FetchChaptersContentRow extends SqliteRow {
  FetchChaptersContentRow(Map<String, dynamic> data) : super(data);

  String get title => data['title'] as String;
  String get content => data['content'] as String;
  int get number => data['number'] as int;
  int get bookId => data['book_id'] as int;
  int get id => data['id'] as int;
  int get parentId => data['parent_id'] as int;
}

/// END FETCHCHAPTERSCONTENT

/// BEGIN FETCHSUBCHAPTERS
Future<List<FetchSubChaptersRow>> performFetchSubChapters(
  Database database, {
  int? chapterId,
  int? bookId,
}) {
  final query = '''
SELECT * FROM chapters WHERE book_id= ${bookId} AND parent_id = ${chapterId} ORDER BY number;
''';
  return _readQuery(database, query, (d) => FetchSubChaptersRow(d));
}

class FetchSubChaptersRow extends SqliteRow {
  FetchSubChaptersRow(Map<String, dynamic> data) : super(data);

  String get title => data['title'] as String;
  String get content => data['content'] as String;
  int get number => data['number'] as int;
  int get bookId => data['book_id'] as int;
  int get id => data['id'] as int;
  int get parentId => data['parent_id'] as int;
}

/// END FETCHSUBCHAPTERS

/// BEGIN SEARCHCONTENT
Future<List<SearchContentRow>> performSearchContent(
  Database database, {
  int? bookId,
  int? chapterId,
  String? content,
}) {
  final query = '''
SELECT chapters.*, books.cover as book_cover 
FROM chapters 
LEFT JOIN books ON chapters.book_id = books.id
WHERE (${bookId} = -1 OR chapters.book_id = ${bookId})
  AND (${chapterId} = -1 OR chapters.number = ${chapterId})
  AND chapters.content LIKE '%${content}%' COLLATE NOCASE
ORDER BY chapters.book_id, chapters.number;
''';
  return _readQuery(database, query, (d) => SearchContentRow(d));
}

class SearchContentRow extends SqliteRow {
  SearchContentRow(Map<String, dynamic> data) : super(data);

  int? get id => data['id'] as int?;
  int? get bookId => data['book_id'] as int?;
  int? get number => data['number'] as int?;
  String? get title => data['title'] as String?;
  String? get content => data['content'] as String?;
  int? get parent => data['parent_id'] as int?;
  String? get bookCover => (data['book_cover'] as String?)?.trim();
}

/// END SEARCHCONTENT

/// BEGIN FETCHBOOKMARKEDBOOKS
Future<List<FetchBookmarkedBooksRow>> performFetchBookmarkedBooks(
  Database database,
) {
  final query = '''
SELECT books.*, bookmarks.id as bookmark_id FROM books 
INNER JOIN bookmarks ON books.id = bookmarks.book_id 
WHERE bookmarks.type = "book" 
ORDER BY bookmarks.created_at DESC;
''';
  return _readQuery(database, query, (d) => FetchBookmarkedBooksRow(d));
}

class FetchBookmarkedBooksRow extends SqliteRow {
  FetchBookmarkedBooksRow(Map<String, dynamic> data) : super(data);

  String? get title => data['title'] as String?;
  int? get id => data['id'] as int?;
  String? get author => data['author'] as String?;
  String? get language => data['language'] as String?;
  String? get description => data['description'] as String?;
  String? get cover => (data['cover'] as String?)?.trim();
  int? get bookmarkId => data['bookmark_id'] as int?;
}
/// END FETCHBOOKMARKEDBOOKS

/// BEGIN FETCHBOOKMARKEDPAGES
Future<List<FetchBookmarkedPagesRow>> performFetchBookmarkedPages(
  Database database,
) {
  final query = '''
SELECT chapters.*, bookmarks.id as bookmark_id FROM chapters 
INNER JOIN bookmarks ON chapters.id = bookmarks.chapter_id 
WHERE bookmarks.type = "pagemark" 
ORDER BY bookmarks.created_at DESC;
''';
  return _readQuery(database, query, (d) => FetchBookmarkedPagesRow(d));
}

class FetchBookmarkedPagesRow extends SqliteRow {
  FetchBookmarkedPagesRow(Map<String, dynamic> data) : super(data);

  String get title => data['title'] as String;
  String get content => data['content'] as String;
  int get number => data['number'] as int;
  int get bookId => data['book_id'] as int;
  int get id => data['id'] as int;
  int get parentId => data['parent_id'] as int;
  int? get bookmarkId => data['bookmark_id'] as int?;
}
/// END FETCHBOOKMARKEDPAGES

/// BEGIN FETCHREADINGHISTORY
Future<List<FetchReadingHistoryRow>> performFetchReadingHistory(
  Database database,
) {
  final query = '''
SELECT books.*, reading_history.chapter_id, reading_history.percent, reading_history.updated_at, chapters.number 
FROM reading_history 
INNER JOIN books ON reading_history.book_id = books.id 
LEFT JOIN chapters ON reading_history.chapter_id = chapters.id
ORDER BY reading_history.updated_at DESC LIMIT 1;
''';
  return _readQuery(database, query, (d) => FetchReadingHistoryRow(d));
}

class FetchReadingHistoryRow extends SqliteRow {
  FetchReadingHistoryRow(Map<String, dynamic> data) : super(data);

  String? get title => data['title'] as String?;
  int? get id => data['id'] as int?;
  String? get author => data['author'] as String?;
  String? get cover => (data['cover'] as String?)?.trim();
  int? get chapterId => data['chapter_id'] as int?;
  double? get percent => data['percent'] as double?;
  int? get number => data['number'] as int?;
}
/// END FETCHREADINGHISTORY
