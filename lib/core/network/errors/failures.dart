import 'package:kai_chat/core/network/errors/extra_model.dart';

abstract class BaseFailure {
  final String message;
  final String? statusCode;
  final int? responseCode;
  final ExtraModel? extra;

  BaseFailure({
    required this.message,
    this.statusCode,
    this.responseCode,
    this.extra,
  });

  String get detailedMessage;

  /// returning current class name as error type
  String get errorType => runtimeType.toString();
}

class ApiFailure extends BaseFailure {
  ApiFailure({
    required String message,
    required String? statusCode,
    required int? responseCode,
    ExtraModel? extra,
  }) : super(
          message: message,
          statusCode: statusCode,
          responseCode: responseCode,
          extra: extra,
        );

  @override
  // String get detailedMessage => '$message \nStatusCode:[$statusCode]';
  String get detailedMessage => message;
}

class GeneralFailure extends BaseFailure {
  GeneralFailure({
    required String message,
    String? statusCode,
    int? responseCode,
  }) : super(
          message: message,
          statusCode: statusCode,
          responseCode: responseCode,
        );

  @override
  // String get detailedMessage => '$message \nStatusCode:[$statusCode]';
  String get detailedMessage => message;
}
