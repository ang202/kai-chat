import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/network/interceptors/http_handshake_interceptor.dart';
import 'package:kai_chat/core/network/interceptors/http_locale_header_interceptor.dart';
import 'package:kai_chat/core/network/interceptors/http_request_header_interceptor.dart';
import 'package:kai_chat/core/network/interceptors/http_user_agent_client_interceptor.dart';
import 'package:kai_chat/core/network/utils/connection_checker.dart';
import 'package:kai_chat/core/network/utils/pretty_dio_logger.dart';
import 'package:kai_chat/core/values/api_constants.dart';
import 'package:dio/dio.dart';

abstract class DioClient {
  Future<Response<dynamic>> get(String uri,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> post(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> put(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> delete(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      bool authorization = true,
      int? timeout});

  Future<Response<dynamic>> download(String uri, String savePath,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      String? method,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout});
}

class DioClientImpl implements DioClient {
  DioClientImpl({required this.dio, required this.connectionChecker}) {
    dio
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout =
          const Duration(seconds: ApiConstants.connectTimeoutInMs)
      ..options.receiveTimeout =
          const Duration(seconds: ApiConstants.receiveTimeoutInMs)
      ..interceptors.add(HttpHandshakeInterceptor())
      ..interceptors.add(HttpRequestHeaderInterceptor())
      ..interceptors.add(HttpUserAgentClientInterceptor())
      ..interceptors.add(HttpLocaleHeaderInterceptor());

    if (!FlavorConfig.isProduction) {
      dio.interceptors.add(_prettyDioLogger);
    }
  }

  final ConnectionChecker connectionChecker;
  final Dio dio;

  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(
      requestHeader: !FlavorConfig
          .isProduction, // print requestHeader if only on DEV or UAT environment
      requestBody: true,
      responseBody: !FlavorConfig
          .isProduction, // print responseBody if only on DEV or UAT environment
      responseHeader: !FlavorConfig.isProduction,
      error: true,
      compact: true,
      maxWidth: _maxLineWidth);

  final String _baseUrl = FlavorConfig.apiUrl;

  @override
  Future<Response<dynamic>> delete(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    bool authorization = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.delete(fullUrl ?? uri,
        data: body, options: Options(headers: headers, extra: extra));
  }

  @override
  Future<Response<dynamic>> download(String uri, String savePath,
      {String? fullUrl,
      String? method,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.download(fullUrl ?? uri, savePath,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: extra,
          method: method,
        ),
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> get(String uri,
      {String? fullUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.get(fullUrl ?? uri,
        queryParameters: queryParameters,
        options: Options(headers: headers, extra: extra),
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> post(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.post(fullUrl ?? uri,
        data: body,
        options: Options(headers: headers, extra: extra),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  @override
  Future<Response<dynamic>> put(String uri,
      {required dynamic body,
      String? fullUrl,
      Map<String, dynamic>? headers,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool authorization = true,
      int? timeout}) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': authorization
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    return await dio.put(fullUrl ?? uri,
        data: body,
        options: Options(headers: headers, extra: extra),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  /// helper function to check if mobile has connection before making API request
  Future<void> _throwExceptionIfNoConnection() async {
    if (await connectionChecker.isConnected() == NetworkStatus.offline) {
      // throw NoInternetConnectionException(
      //     message: AppStrings.noInternetConnection);
    }
  }
}
