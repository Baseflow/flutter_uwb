import 'package:flutter/services.dart';
import 'package:uwb_ios/uwb_api.pigeon.dart';

/// Helper class for setup purposes
class SetupHelperClass {
  static late final MCNearbyServiceAdvertiserHostApi _api =
      MCNearbyServiceAdvertiserHostApi();
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/setup_helper_class');

  /// Checks device iOS-version & UWB compatibility
  /// returns (true) if compatible
  Future<bool> checkPlatformCompatibility() async {
    // final bool status = await _channel.invokeMethod('SetupHelperClass.setUp');
    final bool status = await _api.checkPlatformCompatibility();
    return status;
  }
}
