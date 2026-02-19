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
  String? get cover => data['cover'] as String?;
}

/// END READ ALL BOOKS NAMES
