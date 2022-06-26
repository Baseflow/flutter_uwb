import 'dart:async';

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

import 'multipeer_connectivity_wrapper.dart';

/// Extends UwbPlatform. Directs method calls to the corresponding wrapper and helper classes
class UwbIos extends UwbPlatform {
  /// Sets the UbwPlatform instance
  static void registerWith() {
    UwbPlatform.instance = UwbIos();
  }

  @override
  Future<void> startHost(String peerID, String serviceType) {
    final MCPeerIDWrapper peerId = MCPeerIDWrapper(displayname: peerID);

    final MCNearbyServiceAdvertiserWrapper advertiser =
        MCNearbyServiceAdvertiserWrapper(
      peer: peerId,
      serviceType: serviceType,
    );

    return advertiser.startAdvertisingPeer();
  }
}
