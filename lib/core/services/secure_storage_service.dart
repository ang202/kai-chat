import 'dart:convert';

import 'package:kai_chat/config/flavor_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SecureStorageService extends GetxService {
  final Logger _logger = FlavorConfig.instance.logger;

  /// Find FlutterSecureStorage dependency
  final FlutterSecureStorage _secureStorageInstance = Get.find();

  /// Specific initialization method
  Future<void> setString(String key, String value) async =>
      await _secureStorageInstance.write(
          key: key, value: value, aOptions: _getAndroidOptions());

  Future<void> setBool(String key, bool value) async =>
      await _secureStorageInstance.write(
          key: key, value: value.toString(), aOptions: _getAndroidOptions());

  Future<void> setInt(String key, int value) async =>
      await _secureStorageInstance.write(
          key: key, value: value.toString(), aOptions: _getAndroidOptions());

  Future<void> setDouble(String key, double value) async =>
      await _secureStorageInstance.write(
          key: key, value: value.toString(), aOptions: _getAndroidOptions());

  Future<void> setStringList(String key, List<String> value) async =>
      await _secureStorageInstance.write(
          key: key, value: value.toString(), aOptions: _getAndroidOptions());

  Future<bool> containsKey(String key) async => await _secureStorageInstance
      .containsKey(key: key, aOptions: _getAndroidOptions());

  Future<String?> getString(String key) async =>
      await _secureStorageInstance.read(
          key: key, aOptions: _getAndroidOptions()) ??
      '';

  Future<double?> getDouble(String key) async =>
      double.tryParse(await _secureStorageInstance.read(
              key: key, aOptions: _getAndroidOptions()) ??
          '0.0') ??
      0.0;

  Future<int?> getInt(String key) async =>
      int.tryParse(await _secureStorageInstance.read(
              key: key, aOptions: _getAndroidOptions()) ??
          '0') ??
      0;

  Future<bool?> getBool(String key) async =>
      _parseBoolean(await _secureStorageInstance.read(
              key: key, aOptions: _getAndroidOptions()) ??
          'false');

  Future<List<String>?> getStringList(String key) async =>
      List<String>.from(jsonDecode(await _secureStorageInstance.read(
              key: key, aOptions: _getAndroidOptions()) ??
          '[]'));

  Future<void> delete(String key) async => await _secureStorageInstance.delete(
      key: key, aOptions: _getAndroidOptions());

  Future<void> clear() async => await _secureStorageInstance.deleteAll();

  /// save as json string
  Future<void> setObject(String key, Object object) async {
    String jsonString = '';
    try {
      jsonString = json.encode(object);
      await _secureStorageInstance.write(
          key: key, value: jsonString, aOptions: _getAndroidOptions());
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  /// Read the json string
  Object getObject(String key) async {
    final String jsonString = await _secureStorageInstance.read(
            key: key, aOptions: _getAndroidOptions()) ??
        '';
    Object object = {};
    if (jsonString.isNotEmpty) {
      try {
        object = json.decode(jsonString) ?? {};
      } catch (e) {
        _logger.e(e.toString());
      }
    }

    return object;
  }

  ///to parse string to bool
  bool? _parseBoolean(String? value) {
    if ((value ?? '').toLowerCase() == 'true') {
      return true;
    } else if ((value ?? '').toLowerCase() == 'false') {
      return false;
    } else {
      return false;
    }
  }

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
