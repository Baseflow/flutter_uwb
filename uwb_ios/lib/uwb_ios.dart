
import 'dart:async';

import 'package:flutter/services.dart';

class UwbIos {
  static const MethodChannel _channel = MethodChannel('uwb_ios');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
