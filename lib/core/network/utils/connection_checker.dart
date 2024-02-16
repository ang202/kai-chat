import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { online, offline }

abstract class ConnectionChecker {
  Future<NetworkStatus> isConnected();
  Stream<InternetConnectionStatus> connectivityChanged();
  Future<NetworkStatus> getNetworkStatus(InternetConnectionStatus status);
  Future<bool> hasConnection();
}

class ConnectionCheckerImpl extends ConnectionChecker {
  @override
  Stream<InternetConnectionStatus> connectivityChanged() {
    return InternetConnectionChecker().onStatusChange;
  }

  @override
  Future<NetworkStatus> getNetworkStatus(InternetConnectionStatus status) async {
    return status == InternetConnectionStatus.connected && await InternetConnectionChecker().hasConnection
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }

  @override
  Future<NetworkStatus> isConnected() async {
    return await InternetConnectionChecker().hasConnection ? NetworkStatus.online : NetworkStatus.offline;
  }

  @override
  Future<bool> hasConnection() async {
    return await InternetConnectionChecker().hasConnection ? true : false;
  }
}
