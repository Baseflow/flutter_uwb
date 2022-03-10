import 'package:flutter/services.dart';

/// Contains all the Multipeer Connectivity Framework calls
class MCSessionWrapper {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/mc_session');

  /// Starts the advertiser
  Future<bool?> startHost() async {
    final bool? hostingProcess =
        await _channel.invokeMethod('MCSession.startHost');
    return hostingProcess;
  }

  /// Sends an invite to peer
  Future<bool?> joinHost() async {
    final bool? joiningProcess =
        await _channel.invokeMethod('MCSession.joinHost');
    return joiningProcess;
  }
}
