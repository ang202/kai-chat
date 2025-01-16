import 'dart:convert';
import 'dart:ui';

import 'package:kai_chat/core/base/model/user.dart';
import 'package:kai_chat/core/services/secure_storage_service.dart';
import 'package:kai_chat/core/values/app_strings.dart';

class LocalRepository {
  final SecureStorageService secureStorageService = SecureStorageService();

  final String appAccessToken = AppStrings.appAccessToken;
  final String appAccessTokenExpiryDate = AppStrings.appAccessTokenExpiryDate;
  final String appRefreshTokenExpiryDate = AppStrings.appRefreshTokenExpiryDate;
  final String appRefreshToken = AppStrings.appRefreshToken;
  final String appLanguage = AppStrings.appLocale;
  final String appUser = AppStrings.appUser;

  Future<void> clearStorage() async {
    await Future.wait([
      secureStorageService.delete(appAccessToken),
      secureStorageService.delete(appAccessTokenExpiryDate),
      secureStorageService.delete(appRefreshToken),
      secureStorageService.delete(appRefreshTokenExpiryDate),
      secureStorageService.delete(appUser),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await secureStorageService.getString(appAccessToken);
  }

  Future<String?> getAccessTokenExpiryAt() async {
    return await secureStorageService.getString(appAccessTokenExpiryDate);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorageService.getString(appRefreshToken);
  }

  Future<String?> getRefreshTokenExpiryAt() async {
    return await secureStorageService.getString(appRefreshTokenExpiryDate);
  }

  Future<Locale?> getLanguage() async {
    final String? localeString =
        await secureStorageService.getString(appLanguage);

    return localeString?.isNotEmpty == true
        ? Locale(localeString!.split('-')[0], localeString.split('-')[1])
        : null;
  }

  Future<User?> getUser() async {
    final storageUser = await secureStorageService.getString(appUser) ?? "";
    return storageUser.isEmpty == true
        ? null
        : User.fromJson(jsonDecode(storageUser));
  }

  // Storage Setter

  Future<void> setAccessToken(String? accessToken) async {
    return await secureStorageService.setString(
        appAccessToken, accessToken ?? '');
  }

  Future<void> setAccessTokenExpiryAt(String? accessExpireAt) async {
    return await secureStorageService.setString(
        appAccessTokenExpiryDate, accessExpireAt ?? '');
  }

  Future<void> setRefreshToken(String? refreshToken) async {
    return await secureStorageService.setString(
        appRefreshToken, refreshToken ?? '');
  }

  Future<void> setRefreshTokenExpiryAt(String? refreshExpireAt) async {
    return await secureStorageService.setString(
        appRefreshTokenExpiryDate, refreshExpireAt ?? '');
  }

  Future<void> setLanguage(Locale locale) async {
    final String localeString = locale.toLanguageTag();

    return await secureStorageService.setString(appLanguage, localeString);
  }

  Future<void> setUser(String? value) async {
    return await secureStorageService.setString(appUser, value ?? '');
  }
}
