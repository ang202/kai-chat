import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/network/errors/extra_model.dart';
import 'package:kai_chat/core/network/errors/failures.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:kai_chat/core/routes/app_routes.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static BaseFailure handleDioError(
      dio.DioException dioError, StackTrace stackTrace) {
    if (kDebugMode) {
      print('dioErrorStatusCode: ${dioError.response?.statusCode}');
      print('dioError: ${dioError.toString()}');
      print('stackTrace: $stackTrace');
      print('message: ${dioError.message}');
    }

    switch (dioError.type) {
      case dio.DioExceptionType.badResponse:
        return _parseApiErrorResponse(dioError.response);

      case dio.DioExceptionType.connectionError:
        return GeneralFailure(
          message: "No Internet Connection",
        );

      default:
        return GeneralFailure(
          message: "Something Went Wrong",
          responseCode: dioError.response?.statusCode,
        );
    }
  }

  BaseFailure unHandledError(String error, StackTrace? stackTrace) {
    final logger = FlavorConfig.logger;
    logger.e('Unhandled exception: $error\n$stackTrace');

    return GeneralFailure(message: error);
  }

  static BaseFailure _parseApiErrorResponse(dio.Response? response) {
    final Logger logger = FlavorConfig.logger;

    // -1 is just a fancy way of saying the statusCode is not found
    String? statusCode = "-1";
    int? responseCode = 200;
    String? serverMessage = '';
    ExtraModel? extra;
    try {
      responseCode = response?.statusCode;
      final respondeData =
          response?.data is Map<String, dynamic> ? response?.data : {};

      statusCode = "${respondeData['statusCode']}";
      serverMessage = respondeData['statusMessage'] ?? '';

      extra = respondeData['extra'] != null
          ? ExtraModel.fromJson(respondeData['extra'])
          : null;
    } catch (e, s) {
      logger.i('$e');
      logger.i(s.toString());

      if (e is FormatException) {
        return GeneralFailure(message: e.message);
      }

      serverMessage = e.toString();
    }

    return ApiFailure(
      message: serverMessage ?? '',
      statusCode: statusCode,
      responseCode: responseCode,
      extra: extra,
    );
  }

  Future forceLogout() async {
    final LocalRepository localRepository = Get.find<LocalRepository>();

    await localRepository.clearStorage();

    await Get.offAllNamed(Routes.login);
  }
}
