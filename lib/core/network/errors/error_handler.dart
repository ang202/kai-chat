import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/network/errors/extra_model.dart';
import 'package:kai_chat/core/network/errors/failures.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:kai_chat/core/routes/app_routes.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  BaseFailure handleDioError(dio.DioException dioError, StackTrace stackTrace) {
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
        return GeneralFailure(message: "No internet connection");

      default:
        return GeneralFailure(
          message: "Something went wrong. Please try again later",
          statusCode: dioError.response?.statusCode,
        );
    }
  }

  BaseFailure unHandledError(String error, StackTrace? stackTrace) {
    final logger = FlavorConfig.instance.logger;
    logger.e('Unhandled exception: $error\n$stackTrace');

    return GeneralFailure(message: error);
  }

  BaseFailure _parseApiErrorResponse(dio.Response? response) {
    final Logger logger = FlavorConfig.instance.logger;

    // -1 is just a fancy way of saying the statusCode is not found
    int? statusCode = -1;
    String? serverMessage = '';
    ExtraModel? extra;

    try {
      statusCode = int.tryParse(response?.data['statusCode'] ?? "0");
      serverMessage = response?.data['statusMessage'] ??
          response?.data['error']['message'] ??
          '';

      extra = response?.data['extra'] != null
          ? ExtraModel.fromJson(response?.data['extra'])
          : null;
    } catch (e, s) {
      logger.i('$e');
      logger.i(s.toString());

      if (e is FormatException) {
        return GeneralFailure(message: e.message);
      }

      statusCode = response?.statusCode;

      serverMessage = e.toString();
    }

    return ApiFailure(
        message: serverMessage ?? '', statusCode: statusCode, extra: extra);
  }

  Future forceLogout() async {
    final LocalRepository localRepository = Get.find<LocalRepository>();

    await localRepository.clearStorage();

    await Get.offAllNamed(Routes.login);
  }
}
