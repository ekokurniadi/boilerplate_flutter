import 'package:boilerplate_flutter/core/helpers/dio_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => DioHelper.dio!;

  @lazySingleton
  @Named('DioDownload')
  Dio get dioDownloadImage => Dio(
        BaseOptions(
          baseUrl: '',
        ),
      );

  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
