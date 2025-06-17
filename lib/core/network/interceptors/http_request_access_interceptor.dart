// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as getx;
// import 'package:kai_chat/core/base/base_snackbar.dart';
// import 'package:kai_chat/core/base/main_controller.dart';
// import 'package:kai_chat/core/repositories/local_repository.dart';
// import 'package:kai_chat/core/routes/app_routes.dart';
// import 'package:kai_chat/core/values/api_constants.dart';
// import 'package:kai_chat/core/values/app_strings.dart';

// class HttpRequestAccessInterceptor extends Interceptor {
//   final Dio dio = getx.Get.find();
//   bool isRefreshing = false;
//   List<Function(String)> tokenRefreshQueue = [];
//   LocalRepository localRepository = getx.Get.find();

//   // Check refresh token is expired
//   Future<bool> get ableToRefresh async {
//     final refreshTokenExpireDate =
//         await localRepository.getRefreshTokenExpiryAt();
//     return (refreshTokenExpireDate != null &&
//         refreshTokenExpireDate.isNotEmpty &&
//         DateTime.parse(refreshTokenExpireDate).isAfter(DateTime.now()));
//   }

//   @override
//   Future<void> onError(
//       DioException err, ErrorInterceptorHandler handler) async {
//     if (err.type == DioExceptionType.badResponse && err.response != null) {
//       // Refresh Token
//       if (err.response?.statusCode == 401 &&
//           (err.requestOptions.path != ApiConstants.refreshToken ||
//               err.requestOptions.path != ApiConstants.qrAuthLogin)) {
//         final originalRequest = err.requestOptions;
//         if (await ableToRefresh) {
//           if (isRefreshing) {
//             // Queue the request until token refresh completes
//             final completer = Completer<Response>();
//             tokenRefreshQueue.add((newToken) {
//               originalRequest.headers['Authorization'] = newToken;
//               completer.complete(
//                   dio.fetch(originalRequest)); // Retry the original request
//             });
//             return handler.resolve(await completer.future);
//           }

//           isRefreshing = true;

//           try {
//             // Trigger refresh token
//             final newToken = await triggerRefreshToken();
//             if (newToken != null) {
//               // Trigger callback after refreshToken successful
//               for (var callback in tokenRefreshQueue) {
//                 callback(newToken);
//               }
//               tokenRefreshQueue.clear();
//               originalRequest.headers['Authorization'] = newToken;
//               return handler.resolve(await dio.fetch(originalRequest));
//             }
//           } catch (e) {
//             // Force logout after refresh token failed
//             forceLogout();
//           } finally {
//             isRefreshing = false;
//           }
//         } else {
//           // Force logout directly if refresh token is expired
//           forceLogout();
//         }
//       }
//     }
//     super.onError(err, handler);
//   }

//   Future<String?> triggerRefreshToken() async {
//     final LocalRepository localRepository = getx.Get.find();
//     final refreshToken = await localRepository.getRefreshToken();
//     final accessToken = await localRepository.getAccessToken();
//     final response = await dio.post(ApiConstants.refreshToken,
//         data: AuthTokenRefresh(
//                 refreshToken: refreshToken, accessToken: accessToken)
//             .toJson());

//     if (response.statusCode == 200) {
//       final tokenBody = AuthTokenRefresh.fromJson(response.data);
//       localRepository.setAuthentication(tokenBody);
//       return tokenBody.accessToken;
//     } else {
//       debugPrint("Auth token refresh error: ${response.data}");
//     }
//     return null;
//   }

//   void forceLogout() async {
//     final MainController mainController = getx.Get.find();
//     if (getx.Get.currentRoute != Routes.auth &&
//         getx.Get.currentRoute != Routes.authIntro &&
//         !mainController.isForceLogout.value) {
//       //Set force logout so it won't repeating trigger
//       mainController.onSetForceLogout(value: true);
//       await localRepository.clearStorage();
//       await mainController.logout();
//       BaseSnackBar.show(message: AppStrings.pleaseLoginAgain.tr);
//     }
//   }
// }
