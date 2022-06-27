import 'dart:async';

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

import 'mc_nearby_service_advertiser_wrapper.dart';
import 'mc_browser_view_controller_wrapper.dart';

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

  @override
  Future<void> joinHost(String peerID, String serviceType) {
    final MCPeerIDWrapper peerId = MCPeerIDWrapper(displayname: peerID);
    final MCSessionWrapper mcSession = MCSessionWrapper(peerId: peerId);

    final MCBrowserViewControllerWrapper browser =
        MCBrowserViewControllerWrapper(
            mcSession: mcSession, serviceType: serviceType);
    return browser.presentTheBrowserToViewController();
  }
}
