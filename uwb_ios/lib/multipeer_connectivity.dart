import 'package:flutter/services.dart';

class MCSessionWrapper {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/mc_session');

  Future<bool?> startHost() async {
    final bool? hostingProcess =
        await _channel.invokeMethod('MCSession.startHost');
    return hostingProcess;
  }

  Future<bool?> joinHost() async {
    final bool? joiningProcess =
        await _channel.invokeMethod('MCSession.joinHost');
    return joiningProcess;
  }
}
