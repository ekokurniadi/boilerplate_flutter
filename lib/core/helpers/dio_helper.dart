import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';

@injectable
class DioHelper {
  static Dio? dio;

  static void initialDio(String baseUrl) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

     (dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  }

  static void setDioLogger(String baseUrl) {
    dio!.interceptors.addAll([
      InterceptorsWrapper(
        onResponse: (response, responseInterceptorHandler) {
          log('${response.statusCode} - ${response.data.toString()}\n');
          return responseInterceptorHandler.next(response);
        },
        onRequest: (request, requestInterceptorHandler) {
          log(
            '${request.method} - ${request.path} - ${request.data} - ${request.queryParameters}',
          );
          return requestInterceptorHandler
              .next(request.copyWith(path: '${request.path}/'));
        },
        onError: (DioException error, errorInterceptor) async {
          log(error.message ?? 'Something went wrong');
          return errorInterceptor.next(error);
        },
      ),
      // if (!kReleaseMode) alice.getDioInterceptor(),
    ]);
  }

  static setDioHeader(String? token) {
    dio!.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log('token user: $token');
  }

  static String exception(DioException e) {
    String message = 'Failed to process your request';
    // Handle DioError type-specific errors
    if (e.response != null) {
      log('DioError response status: ${e.response!.statusCode}');
      log('DioError response data: ${e.response!.data}');
      log('DioError response headers: ${e.response!.headers}');
      if (e.response?.statusCode == 500) {
        try {
          message = e.response?.data['data'] ?? 'Something went wrong';
        } catch (_) {
          message = e.response?.statusMessage ?? 'Something went wrong';
        }
      } else {
        if (e.response?.data != null) {
          try {
            message = e.response?.data['message'] ?? 'Something went wrong';
          } catch (_) {
            message = e.response?.statusMessage ?? 'Something went wrong';
          }
        }
      }
    } else {
      log('DioError: ${e.message}');
      message = e.message ?? 'Something went wrong';
    }
    return message;
  }
}
