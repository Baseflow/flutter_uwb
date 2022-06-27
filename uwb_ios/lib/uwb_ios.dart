import 'dart:async';
import 'package:flutter/services.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// The [UwbIos] class.
///
/// Contains all the methodchannel calls.
class UwbIos extends UwbPlatform {
  static const MethodChannel _channel = MethodChannel('uwb_ios');

  /// Sets the UbwPlatform instance
  static void registerWith() {
    UwbPlatform.instance = UwbIos();
  }

  /// Methoc call that gets the platformversion from iOS.
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
