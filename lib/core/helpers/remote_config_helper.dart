import 'dart:convert';

import 'package:flutter/services.dart';

class RemoteConfigHelper {
  const RemoteConfigHelper._();

  static Future<String> getNearbyServerConfig() async {
    try {
      final defaultRemoteConfig = await rootBundle.loadString(
        'assets/remote_config/config.json',
      );

      final decoded = jsonDecode(defaultRemoteConfig);
      final result = jsonEncode(decoded['nearby_server_config']);

      return result;
    } catch (e) {
      return '';
    }
  }
}
