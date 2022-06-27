import 'dart:async';

import 'package:flutter/services.dart';

/// The [UwbIos] class.
///
/// Contains all the methodchannel calls.
class UwbIos {
  static const MethodChannel _channel = MethodChannel('uwb_ios');

  /// Methoc call that gets the platformversion from iOS.
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
