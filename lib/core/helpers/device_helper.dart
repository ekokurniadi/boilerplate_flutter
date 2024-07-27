import 'dart:convert';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:boilerplate_flutter/core/constant/preference_constant.dart';
import 'package:boilerplate_flutter/core/helpers/global_helper.dart';
import 'package:boilerplate_flutter/injector.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceHelper {
  static Future<String> _getDeviceUUID() async {
    String uuid = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      uuid = await _generateAndroidUUID();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      uuid = iosDeviceInfo.identifierForVendor!;
    } else if (Platform.isWindows) {
      final windowsDeviceInfo = await PlatformDeviceId.getDeviceId;
      uuid = windowsDeviceInfo ?? '';
    } else if (Platform.isMacOS) {
      final macDeviceInfo = await PlatformDeviceId.getDeviceId;
      uuid = macDeviceInfo ?? '';
    }

    return uuid;
  }

  static Future<String> _generateAndroidUUID() async {
    String uuid = '';

    // try get unique device identifier using Widevine DRM
    MobileDeviceIdentifier mobileDeviceIdentifier = MobileDeviceIdentifier();
    uuid = await mobileDeviceIdentifier.getDeviceId() ?? '';
    if (uuid.isNotEmpty) {
      final bytes = utf8.encode(uuid);
      final hash = md5.convert(bytes);
      uuid = hash.toString();
    }

    if (uuid.isEmpty) {
      // try get unique device identifier using SECURE.ANDROID_ID
      const androidIdPlugin = AndroidId();
      uuid = await androidIdPlugin.getId() ?? '';
    }
    if (uuid.isEmpty) {
      // (edge case) if still no id, try get unique device identifier using DeviceInfoPlugin (Build.ID)
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      uuid = androidInfo.id;
    }
    return uuid;
  }

  static String? getDeviceId() {
    final uuid = getIt<SharedPreferences>().getString(
      PreferenceConstant.deviceID,
    );
    String finalUUID = '';
    if (!GlobalHelper.isEmpty(uuid)) {
      if (uuid!.contains('-')) {
        finalUUID = uuid.replaceAll('-', '');
      } else {
        finalUUID = uuid;
      }
    }
    String input = finalUUID;
    // Define a regular expression to match alphabets and numbers
    RegExp regExp = RegExp(r'[a-zA-Z0-9]+');

    // Find all matches in the input string
    Iterable<Match> matches = regExp.allMatches(input);

    // Concatenate all matched substrings
    String result = matches.map((match) => match.group(0)).join();

    return result.trim();
  }

  static Future<String?> setDeviceID() async {
    final uuid = await _getDeviceUUID();
    String finalUUID = '';
    if (uuid.contains('-')) {
      finalUUID = uuid.replaceAll('-', '');
    } else {
      finalUUID = uuid;
    }

    String input = finalUUID;
    // Define a regular expression to match alphabets and numbers
    RegExp regExp = RegExp(r'[a-zA-Z0-9]+');

    // Find all matches in the input string
    Iterable<Match> matches = regExp.allMatches(input);

    // Concatenate all matched substrings
    String result = matches.map((match) => match.group(0)).join();

    getIt<SharedPreferences>().setString(
      PreferenceConstant.deviceID,
      result.trim(),
    );

    return getDeviceId();
  }

  static Future<String> getAppVersion() async {
    String version = '';

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    return version;
  }

  static Future<AppInformationData> getAppInformationData() async {
    String os = '';
    String deviceName = '';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final apkVersion = packageInfo.version;

    if (Platform.isWindows) {
      // os = 'Windows';
      // final winPlatform = await FlutterRustPlugin().getPlatformVersion();
      // deviceName =
      //     '${winPlatform.edition} ${winPlatform.version} ${winPlatform.bitness}';
    } else if (Platform.isAndroid) {
      os = 'Android';
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceName = '${androidInfo.model} ${androidInfo.version.sdkInt}';
    } else if (Platform.isMacOS) {
      os = 'MacOS';
      final macOsInfo = await DeviceInfoPlugin().macOsInfo;
      deviceName = '${macOsInfo.model} ${macOsInfo.osRelease}';
    } else {
      os = 'IOS';
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      deviceName = '${iosInfo.model} ${iosInfo.systemVersion}';
    }

    return AppInformationData(
      operatingSystem: os,
      deviceName: deviceName,
      apkVersion: apkVersion,
    );
  }
}

class AppInformationData extends Equatable {
  const AppInformationData({
    required this.operatingSystem,
    required this.deviceName,
    required this.apkVersion,
  });
  final String operatingSystem;
  final String deviceName;
  final String apkVersion;

  @override
  List<Object?> get props => [];
}
