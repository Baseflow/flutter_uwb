import 'package:flutter/services.dart';

class NISessionWrapper {
  static const MethodChannel _channel = MethodChannel('com.baseflow.uwb/ni_session');

  Future <String> startNISession() async{
    print("NISessionWrapper - startNISession() called");
    final String? status = await _channel.invokeMethod("NISession.start");
    return status ?? "";
  }
}