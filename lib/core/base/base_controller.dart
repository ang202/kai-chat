import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/enum/view_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

abstract class BaseController extends GetxController {
  final Logger logger = FlavorConfig.instance.logger;

  //Controls page state
  final Rx<ViewState> _pageSateController = ViewState.initial.obs;

  ViewState get viewState => _pageSateController.value;

  ViewState updateViewState(ViewState state) => _pageSateController(state);

  ViewState setLoading() => updateViewState(ViewState.loading);

  ViewState setSuccess() => updateViewState(ViewState.success);

  // ViewState setError() => updateViewState(ViewState.error);

  ViewState setNoInternet() => updateViewState(ViewState.noInternet);

  void showErrorMessage(String msg) {
    // showErrorSnackBar(msg);
  }

  // Use this method when you have more than one ViewState in a controller
  // this will help to different from the main ViewState used for say API calling
  void setRxViewState(Rx<ViewState> rxViewState, ViewState value) {
    if (value != rxViewState.value) {
      rxViewState.value = value;
    }
  }

  bool _isHomeIndicatorVisible() {
    final bool isHomeIndicatorVisibleiOS =
        MediaQuery.of(Get.context!).size.width == 375 &&
            MediaQuery.of(Get.context!).size.height == 667;

    return isHomeIndicatorVisibleiOS || GetPlatform.isAndroid;
  }

  bool get isHomeIndicatorVisible => _isHomeIndicatorVisible();

  // ViewState setError(Failure f) {
  //   logger.e('Basecontroller error: >>>>>>> ${f.detailedMessage}');

  //   if (f is NoInternetConnectionFailure) {
  //     showErrorMessage(f.detailedMessage.tr);
  //   } else {
  //     showErrorMessage(f.detailedMessage);
  //   }

  //   return updateViewState(ViewState.error);
  // }
}
