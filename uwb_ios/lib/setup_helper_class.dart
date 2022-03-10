import 'package:flutter/services.dart';

/// Helper class for setup purposes
class SetupHelperClass {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/setup_helper_class');

  /// Checks device iOS-version & UWB compatibility
  /// returns (true) if compatible
  Future<bool?> setUp() async {
    final bool? status = await _channel.invokeMethod('SetupHelperClass.setUp');
    return status ?? false;
  }
}
