import 'package:kai_chat/core/network/errors/extra_model.dart';

abstract class BaseFailure {
  final String message;
  final int? statusCode;
  final ExtraModel? extra;

  BaseFailure({required this.message, this.statusCode, this.extra});

  String get detailedMessage;

  /// returning current class name as error type
  String get errorType => runtimeType.toString();
}

class ApiFailure extends BaseFailure {
  ApiFailure(
      {required String message, required int? statusCode, ExtraModel? extra})
      : super(message: message, statusCode: statusCode, extra: extra);

  @override
  // String get detailedMessage => '$message \nStatusCode:[$statusCode]';
  String get detailedMessage => message;
}

class GeneralFailure extends BaseFailure {
  GeneralFailure({required String message, int? statusCode})
      : super(message: message, statusCode: statusCode);

  @override
  // String get detailedMessage => '$message \nStatusCode:[$statusCode]';
  String get detailedMessage => message;
}
