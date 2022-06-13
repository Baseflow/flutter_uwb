import 'package:flutter/services.dart';

/// Contains all the Multipeer Connectivity Framework calls
class MCSessionWrapper {
  static const MethodChannel _channel =
      MethodChannel('com.baseflow.uwb/mc_session');

  /// Starts the advertiser
  Future<bool?> startHost(String peerID, String serviceType) async {
    final Map<String, String> parameters = <String, String>{
      'peerID': peerID,
      'serviceType': serviceType
    };
    final bool? hostingProcess =
        await _channel.invokeMethod('MCSession.startHost', parameters);
    return hostingProcess;
  }

  /// Sends an invite to peer
  Future<bool?> joinHost(String peerID, String serviceType) async {
    final Map<String, String> parameters = <String, String>{
      'peerID': peerID,
      'serviceType': serviceType
    };
    final bool? joiningProcess =
        await _channel.invokeMethod('MCSession.joinHost', parameters);
    return joiningProcess;
  }
}
