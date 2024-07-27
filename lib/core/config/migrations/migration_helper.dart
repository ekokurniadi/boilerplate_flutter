import 'package:sqflite/sqflite.dart';

class MigrationHelper {
  MigrationHelper(this.database);

  final Database database;

  Future<void> insertColumns({
    required String tableName,
    required List<ColumnEntity> columns,
  }) async {
    for (final column in columns) {
      final checkColumn = await database.rawQuery(
        'PRAGMA table_info($tableName)',
      );
      bool columnIsExist = false;

      for (final checker in checkColumn) {
        if (checker['name'] == column.name) {
          columnIsExist = true;
        }
      }

      if (!columnIsExist) {
        String defaultValue = '';
        if (column.defaultValue != null) {
          defaultValue = ' DEFAULT  ${column.defaultValue}';
        }
        await database.execute(
          'ALTER TABLE $tableName ADD ${column.toQuery()} $defaultValue;',
        );
      }
    }
  }
}

// * Other

class ColumnEntity {
  ColumnEntity({
    required this.name,
    required this.type,
    this.defaultValue,
    this.isPrimaryKey = false,
  });

  final String name;
  final ColumnType type;
  final String? defaultValue;
  final bool isPrimaryKey;

  String toQuery() => '$name ${type.toQuery()}';
}

enum ColumnType { string, double, integer, bool }

extension ParseToString on ColumnType {
  String toQuery() {
    switch (this) {
      case ColumnType.string:
        return 'TEXT';
      case ColumnType.double:
        return 'DOUBLE';
      default:
        return 'INTEGER';
    }
  }
}

abstract class MigrationBuilder {
  String build();
  MigrationBuilder createTable(String tableName);
  MigrationBuilder addColumns({required List<ColumnEntity> columns});
}

class MigrationBuilderImpl extends MigrationBuilder {
  String query = '';
  @override
  MigrationBuilder addColumns({
    required List<ColumnEntity> columns,
  }) {
    for (var i = 0; i < columns.length; i++) {
      String defaultValue = '';
      if (columns[i].defaultValue != null) {
        defaultValue = ' DEFAULT  ${columns[i].defaultValue}';
      }
      String primary = '';
      if (columns[i].isPrimaryKey) {
        primary = ' PRIMARY KEY AUTOINCREMENT ';
      }
      String separator = '';
      if (i < columns.length - 1) {
        separator = ',';
      } else {
        separator = ')';
      }
      query +=
          '${columns[i].name} ${columns[i].type.toQuery()} $primary $defaultValue $separator';
    }

    return this;
  }

  @override
  String build() {
    return query;
  }

  @override
  MigrationBuilder createTable(String tableName) {
    query += 'CREATE TABLE IF NOT EXISTS $tableName (';
    return this;
  }
}
