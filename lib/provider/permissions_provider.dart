import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService extends ChangeNotifier {
  bool showPassword = false;

  Future<void> requestStoragePermission() async {
    var serviceStatus = await Permission.storage.isGranted;

    bool isStorageOn = serviceStatus == ServiceStatus.enabled;
    debugPrint(isStorageOn.toString());

    var status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      debugPrint('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      debugPrint('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      debugPrint('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  void togglevisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
