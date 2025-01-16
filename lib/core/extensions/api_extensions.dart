import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/base/model/tuple_response.dart';
import 'package:kai_chat/core/network/errors/error_handler.dart';
import 'package:kai_chat/core/network/errors/failures.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:kai_chat/core/services/sentry_service.dart';
import 'package:logger/logger.dart';

extension DioResponseExtension<T> on Future<Response<T>> {
  Future handleResponse(
      {required Function(TupleResponse data) onSuccess,
      required Function(BaseFailure) onError}) async {
    final Logger logger = FlavorConfig.instance.logger;
    final LocalRepository localRepository = getx.Get.find();
    try {
      final Response response = await this;
      final token = response.headers["authorization"]?[0];
      if (token != null) {
        localRepository.setAccessToken(token);
      }
      onSuccess.call(TupleResponse(
          data: response.data,
          pages: response.headers["total-pages"]?[0] ?? "",
          counts: response.headers["total-count"]?[0] ?? ""));
    } on DioException catch (dioError, stackTrace) {
      dioError.type != DioExceptionType.badResponse
          ? await SentryService.reportError(
              shouldReportError: true,
              error: dioError,
              stackTrace: stackTrace,
            )
          : null;
      final BaseFailure exception =
          ErrorHandler().handleDioError(dioError, stackTrace);
      logger.d(
          '!!! Throwing error from API: Exception: ${exception.runtimeType}, Status Code: ${exception.statusCode}, Message: ${exception.message} !!!');
      onError.call(exception);
      // throw exception;
    } catch (error, stackTrace) {
      final formattedError = error is GeneralFailure
          ? error
          : ErrorHandler().unHandledError('$error', stackTrace);
      logger.e('!!! Generic error: $error !!!');
      logger.e('!!! Stacktrace: $stackTrace !!!');

      await SentryService.reportError(
        shouldReportError: true,
        error: error,
        stackTrace: stackTrace,
      );

      onError.call(formattedError);
    }
  }
}
