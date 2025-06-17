import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequest {
  final BuildContext context;

  PermissionRequest(this.context);

  static PermissionRequest of(BuildContext context) {
    return PermissionRequest(context);
  }

  Future<void> request({required Permission type, VoidCallback? action}) async {
    final status = await type.request();
    if (status.isGranted) {
      action?.call();
    } else {
      _displayDialog(type);
    }
  }

  void _displayDialog(Permission type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: Text(
            "Please allow ${type.toString().replaceAll("Permission.", "")}"),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
            child: const Text("Open Setting"),
          ),
        ],
      ),
    );
  }
}
