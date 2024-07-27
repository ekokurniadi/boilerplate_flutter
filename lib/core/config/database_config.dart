// ignore_for_file: unnecessary_import

import 'dart:developer';
import 'dart:io';

import 'package:boilerplate_flutter/core/config/migrations/migrations.dart';
import 'package:boilerplate_flutter/core/constant/app_constant.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseConfig {
  const DatabaseConfig._();

  static Database? _database;

  static Future<Database> get database async {
    if (_database == null) {
      log(Migrations.tableList.length.toString(), name: 'migration');

      String storePath = '';

      if (Platform.isWindows) {
        final directory = await getApplicationSupportDirectory();
        storePath = p.join(directory.path, AppConstant.databaseName);

        _database = await databaseFactoryFfi.openDatabase(
          storePath,
          options: OpenDatabaseOptions(
            version: Migrations.tableList.length,
            onUpgrade: (db, oldVersion, newVersion) async {
              for (int i = oldVersion; i < newVersion; i++) {
                await Migrations.tableList[i].up(db);
                log('migration to ${i+1} ${Migrations.tableList[i].runtimeType} successful ', name: 'migration');
              }
            },
          ),
        );
      } else {
        final path = await getDatabasesPath();
        final dbPath = p.join(path, AppConstant.databaseName);
        _database = await openDatabase(
          dbPath,
          version: Migrations.tableList.length,
          onUpgrade: (Database db, int oldVersion, int newVersion) async {
            for (int i = oldVersion; i < newVersion; i++) {
              await Migrations.tableList[i].up(db);
              log('migration to ${i+1} successful', name: 'migration');
            }
          },
        );
      }
    }

    return _database!;
  }
}
