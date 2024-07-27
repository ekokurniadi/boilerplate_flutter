// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:boilerplate_flutter/core/helpers/dio_helper.dart' as _i147;
import 'package:boilerplate_flutter/core/module/network_module.dart' as _i501;
import 'package:boilerplate_flutter/core/module/storage_module.dart' as _i776;
import 'package:boilerplate_flutter/core/module/utilities_module.dart' as _i187;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:cron/cron.dart' as _i769;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:sqflite/sqflite.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final utilityModule = _$UtilityModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i147.DioHelper>(() => _i147.DioHelper());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreference,
      preResolve: true,
    );
    gh.lazySingleton<_i779.Database>(() => storageModule.database);
    gh.lazySingleton<_i769.Cron>(() => utilityModule.cron);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dioDownloadImage,
      instanceName: 'DioDownload',
    );
    return this;
  }
}

class _$StorageModule extends _i776.StorageModule {}

class _$UtilityModule extends _i187.UtilityModule {}

class _$NetworkModule extends _i501.NetworkModule {}
