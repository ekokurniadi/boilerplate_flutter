import 'package:boilerplate_flutter/app.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class StorageModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get sharedPreference async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  Database get database => App.database;
}
