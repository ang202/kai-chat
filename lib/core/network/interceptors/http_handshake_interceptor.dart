import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HttpHandshakeInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    if (err.error is HandshakeException) {
      // Get.offAll(
      //     () => MaintenanceUpdateView(disableType: DisableAppType.maintenance),
      //     binding: MaintenanceUpdateBinding());

      return handler.reject(err);
    } else {
      return handler.next(err);
    }
  }
}
