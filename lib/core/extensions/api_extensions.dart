import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/network/errors/error_handler.dart';
import 'package:kai_chat/core/network/errors/failures.dart';
import 'package:kai_chat/core/services/sentry_service.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

extension DioResponseExtension<T> on Future<Response<T>> {
  Future handleResponse(
      {required Function(dynamic) onSuccess,
      required Function(BaseFailure) onError}) async {
    final Logger logger = FlavorConfig.instance.logger;
    try {
      final Response response = await this;

      onSuccess.call(response.data);
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
      logger.e(
          'Throwing error from BaseRemoteDataSource: >>>>>>> Exception: ${exception.runtimeType}, Message: ${exception.message}');
      onError.call(exception);
      // throw exception;
    } catch (error, stackTrace) {
      final formattedError = error is GeneralFailure
          ? error
          : ErrorHandler().unHandledError('$error', stackTrace);
      logger.e('Generic error: >>>>>>> $error');
      logger.e('Stacktrace: >>>>>>> $stackTrace');

      await SentryService.reportError(
        shouldReportError: true,
        error: error,
        stackTrace: stackTrace,
      );

      onError.call(formattedError);
    }
  }
}
