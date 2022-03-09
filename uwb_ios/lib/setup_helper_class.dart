import 'package:flutter/services.dart';

class SetupHelperClass {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/setup_helper_class');

  Future<bool?> setUp() async {
    final bool? status = await _channel.invokeMethod('SetupHelperClass.setUp');
    return status ?? false;
  }
}
