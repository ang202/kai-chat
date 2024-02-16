import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HttpLocaleHeaderInterceptor extends Interceptor {
  final LocalRepository localRepository = Get.find();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Locale? locale = await localRepository.getLanguage();

    // if (locale == Apptranslations.localeEN) {
    //   options.headers['x-locale'] = 'en';
    // }
    // if (locale == Apptranslations.localeMY) {
    //   options.headers['x-locale'] = 'ms';
    // }
    return handler.next(options);
  }
}
