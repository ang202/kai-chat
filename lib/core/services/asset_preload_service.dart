import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/values/app_assets.dart';
import 'package:lottie/lottie.dart';

class AssetPreloadService extends GetxService {
  final Map<String, LottieComposition> _lottieCache =
      <String, LottieComposition>{};

  @override
  void onInit() {
    cacheAllAssets();
    super.onInit();
  }

  void cacheAllAssets() {
    List<String> lottieAssets = [
      AppAssets.welcomeLottie,
    ];
    for (final path in lottieAssets) {
      AssetLottie(path).load().then((composition) {
        _lottieCache[path] = composition;
      });
    }
  }

  Widget? load(String assetName) {
    final LottieComposition? composition = _lottieCache[assetName];
    if (composition == null) {
      return null;
    }
    return Lottie(composition: composition);
  }
}
