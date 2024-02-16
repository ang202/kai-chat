import 'dart:ui';

import 'package:kai_chat/core/enum/user_role.dart';
import 'package:kai_chat/core/services/secure_storage_service.dart';
import 'package:kai_chat/core/values/app_strings.dart';

class LocalRepository {
  final SecureStorageService secureStorageService = SecureStorageService();

  final String accessExpireTime = AppStrings.storageAccessExpireAt;
  final String accessTokenKey = AppStrings.storageAccessToken;
  final String coolingOffKey = AppStrings.storageCoolingOff;
  final String coolingOffTimeKey = AppStrings.storageCoolingOffTime;
  final String customerNameKey = AppStrings.storageName;
  final String deviceBiometricKey = AppStrings.storageDeviceBiometricKey;
  final String deviceLinkedKey = AppStrings.storageDeviceLinkedKey;
  final String merchantIdKey = AppStrings.storageMerchantId;
  final String idNumberKey = AppStrings.storageUsername;
  final String lastLoginDateKey = AppStrings.storageLastLoginDate;
  final String privateKey = AppStrings.storagePrivateKey;
  final String publicKey = AppStrings.storagePublicKey;
  final String refreshExpireTime = AppStrings.storageRefreshExpireAt;
  final String refreshTokenKey = AppStrings.storageRefreshToken;
  final String tncAgreedKey = AppStrings.storageTnCAgreed;
  final String userFirstTimeKey = AppStrings.storageFirstTime;
  final String userIdKey = AppStrings.storageUserId;
  final String userRoleKey = AppStrings.storageUserRole;
  final String userRolesKey = AppStrings.storageUserRoles;
  final String fundTransferArgumentKey = AppStrings.storageFundTransferArgument;
  final String outletNameKey = AppStrings.storageOutletName;
  final String languageKey = AppStrings.storageLanguage;
  final String tncVersionKey = AppStrings.storageTncVersion;
  final String emvInitialization = AppStrings.storageTncVersion;

  Future<void> clearStorage() async {
    await Future.wait([
      secureStorageService.delete(userIdKey),
      secureStorageService.delete(accessTokenKey),
      secureStorageService.delete(accessExpireTime),
      secureStorageService.delete(refreshTokenKey),
      secureStorageService.delete(refreshExpireTime),
      secureStorageService.delete(userRoleKey),
      secureStorageService.delete(userRolesKey),
      secureStorageService.delete(lastLoginDateKey),
    ]);
  }

  Future<void> deleteUsername() async {
    await Future.wait([
      secureStorageService.delete(customerNameKey),
      secureStorageService.delete(idNumberKey),
      secureStorageService.delete(tncVersionKey),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await secureStorageService.getString(accessTokenKey);
  }

  Future<String?> getAccessTokenExpireAt() async {
    return await secureStorageService.getString(accessExpireTime);
  }

  Future<String?> getMerchantId() async {
    return await secureStorageService.getString(merchantIdKey);
  }

  Future<DateTime?> getLastLoginDate() async {
    final String? lastLoginDate =
        await secureStorageService.getString(lastLoginDateKey);
    if (lastLoginDate?.isNotEmpty == true) {
      return DateTime.parse(lastLoginDate!);
    }

    return null;
  }

  Future<String?> getLinkedKey() async {
    return await secureStorageService.getString(deviceLinkedKey);
  }

  Future<String?> getName() async {
    return await secureStorageService.getString(customerNameKey);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorageService.getString(refreshTokenKey);
  }

  Future<String?> getRefreshTokenExpireAt() async {
    return await secureStorageService.getString(refreshExpireTime);
  }

  Future<UserRole?> getUserRole() async {
    return UserRoleUtil.getRole(
        await secureStorageService.getString(userRoleKey));
  }

  Future<String?> getUserId() async {
    return await secureStorageService.getString(userIdKey);
  }

  Future<String?> getUsername() async {
    return await secureStorageService.getString(idNumberKey);
  }

  Future<String?> getOutletName() async {
    return await secureStorageService.getString(outletNameKey);
  }

  Future<Locale?> getLanguage() async {
    final String? localeString =
        await secureStorageService.getString(languageKey);

    return localeString?.isNotEmpty == true
        ? Locale(localeString!.split('-')[0], localeString.split('-')[1])
        : null;
  }

  Future<void> setAccessExpiryAt(String? accessExpireAt) async {
    return await secureStorageService.setString(
        accessExpireTime, accessExpireAt ?? '');
  }

  Future<void> setAccessToken(String? accessToken) async {
    return await secureStorageService.setString(
        accessTokenKey, accessToken ?? '');
  }

  Future<void> setBiometricDeviceKey(String deviceKey) async {
    return await secureStorageService.setString(deviceBiometricKey, deviceKey);
  }

  Future<void> setDeviceLinkedKey(String linkedKey) async {
    return await secureStorageService.setString(deviceLinkedKey, linkedKey);
  }

  Future<void> setLastLoginDate(DateTime? lastLoginDate) async {
    return await secureStorageService.setString(lastLoginDateKey,
        lastLoginDate?.toIso8601String() ?? DateTime.now().toIso8601String());
  }

  Future<void> setName(String? name) async {
    return await secureStorageService.setString(customerNameKey, name ?? '');
  }

  Future<void> setPrivateKey(String rsaPrivateKey) async {
    return await secureStorageService.setString(privateKey, rsaPrivateKey);
  }

  Future<void> setPublicKey(String rsaPublicKey) async {
    return await secureStorageService.setString(publicKey, rsaPublicKey);
  }

  Future<void> setRefreshExpiryAt(String? refreshExpireAt) async {
    return await secureStorageService.setString(
        refreshExpireTime, refreshExpireAt ?? '');
  }

  Future<void> setRefreshToken(String? refreshToken) async {
    return await secureStorageService.setString(
        refreshTokenKey, refreshToken ?? '');
  }

  Future<void> setUserId(String? userId) async {
    return await secureStorageService.setString(userIdKey, userId ?? '');
  }

  Future<void> setUsername(String username) async {
    return await secureStorageService.setString(idNumberKey, username);
  }

  Future<void> setMerchantId(String? merchantId) async {
    return await secureStorageService.setString(
        merchantIdKey, merchantId ?? '');
  }

  Future<void> setUserRole(String? role) async {
    return await secureStorageService.setString(userRoleKey, role ?? '');
  }

  Future<void> setOutletName(String? outlet) async {
    return await secureStorageService.setString(outletNameKey, outlet ?? '');
  }

  Future<void> setLanguage(Locale locale) async {
    final String localeString = locale.toLanguageTag();

    return await secureStorageService.setString(languageKey, localeString);
  }

  Future<void> deleteLinkedKey() async {
    await secureStorageService.delete(deviceLinkedKey);
  }
}
