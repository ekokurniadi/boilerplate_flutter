import 'dart:developer';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  Future<void> checkPermission() async {
    if (!Platform.isWindows) {
      PermissionStatus permissionCamera = await Permission.camera.status;
      PermissionStatus permissionLocation = await Permission.location.status;
      PermissionStatus permissionPhone = await Permission.phone.status;
      PermissionStatus permissionStorage = await Permission.storage.status;
      PermissionStatus permissionBluetooth = await Permission.bluetooth.status;

      List<Permission> askPermissionList = [];

      if (permissionCamera != PermissionStatus.granted) {
        askPermissionList.add(Permission.camera);
      }

      if (permissionLocation != PermissionStatus.granted) {
        askPermissionList.add(Permission.location);
      }

      if (permissionPhone != PermissionStatus.granted) {
        askPermissionList.add(Permission.phone);
      }

      if (permissionStorage != PermissionStatus.granted) {
        askPermissionList.add(Permission.storage);
      }
      if (permissionBluetooth != PermissionStatus.granted) {
        askPermissionList.add(Permission.bluetooth);
      }

      if (askPermissionList.isNotEmpty) {
        final statuses = await askPermissionList.request();
        log('PERMISSION CAMERA STATUS - ${statuses[Permission.camera]}');
        log('PERMISSION LOCATION STATUS - ${statuses[Permission.location]}');
        log('PERMISSION PHONE STATUS - ${statuses[Permission.phone]}');
        log('PERMISSION STORAGE STATUS - ${statuses[Permission.storage]}');
        await checkPermissionExternalStorage();
      }
    } else {
      List<Permission> askPermissionList = [];
      askPermissionList.add(Permission.photos);
      askPermissionList.add(Permission.location);
      askPermissionList.add(Permission.photosAddOnly);
      askPermissionList.add(Permission.reminders);
      askPermissionList.add(Permission.appTrackingTransparency);
      askPermissionList.add(Permission.criticalAlerts);
      askPermissionList.add(Permission.camera);
      askPermissionList.add(Permission.systemAlertWindow);
      askPermissionList.add(Permission.bluetooth);
      askPermissionList.add(Permission.bluetoothAdvertise);
      askPermissionList.add(Permission.bluetoothScan);
      askPermissionList.add(Permission.notification);
      if (askPermissionList.isNotEmpty) {
        final statuses = await askPermissionList.request();
        statuses.map((key, value) {
          log('$key => $value');
          return MapEntry(key, value);
        });
      }
    }
  }

  Future<bool> checkPermissionExternalStorage() async {
    try {
      PermissionStatus permissionExternalStorage =
          await Permission.manageExternalStorage.status;

      List<Permission> askPermissionList = [];

      if (permissionExternalStorage != PermissionStatus.granted) {
        askPermissionList.add(Permission.manageExternalStorage);
      }

      if (askPermissionList.isNotEmpty) {
        final statuses = await askPermissionList.request();
        log('PERMISSION EXTERNAL STORAGE - ${statuses[Permission.manageExternalStorage]}');
        if (statuses[Permission.manageExternalStorage] ==
            PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
