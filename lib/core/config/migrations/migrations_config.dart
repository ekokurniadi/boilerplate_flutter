import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class MigrationConfig {
  Future<void> up(Database db);
}
