import 'package:flutter/services.dart';

class MCSessionWrapper {
  static const MethodChannel _channel = MethodChannel('com.baseflow.uwb/mc_session');

  Future<String> startMCSession() async {
    print("MCSessionWrapper - startMCSession() called");
    final String? status = await _channel.invokeMethod('MCSession.start');
    return status ?? "";
  }
}