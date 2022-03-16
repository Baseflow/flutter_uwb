
import 'dart:async';

import 'package:flutter/services.dart';

class Uwb {
  static const MethodChannel _channel = MethodChannel('uwb');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
