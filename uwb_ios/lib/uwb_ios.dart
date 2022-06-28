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

  /// Callback that is called when starting the advertiser failed.
  void Function()? onAdvertisingFailure;

  /// Callback that is called when an invitation is received from a connecting
  /// peer.
  void Function(String peerName, String? context)? onReceiveInvitation;

  @override
  Future<void> startHost(String peerID, String serviceType) {
    final MCPeerIDWrapper peerId = MCPeerIDWrapper(displayName: peerID);

    final MCNearbyServiceAdvertiserWrapper advertiser =
        MCNearbyServiceAdvertiserWrapper(
      peer: peerId,
      serviceType: serviceType,
    );

    advertiser.setDelegate(_NearbyServiceAdvertiserDelegate(this));

    return advertiser.startAdvertisingPeer();
  }

  @override
  Future<void> joinHost(String peerID, String serviceType) {
    final MCPeerIDWrapper peerId = MCPeerIDWrapper(displayName: peerID);
    final MCSessionWrapper mcSession = MCSessionWrapper(peerId: peerId);

    final MCBrowserViewControllerWrapper browser =
        MCBrowserViewControllerWrapper(
            mcSession: mcSession, serviceType: serviceType);
    return browser.presentTheBrowserToViewController();
  }
}

class _NearbyServiceAdvertiserDelegate
    extends MCNearbyServiceAdvertiserDelegateWrapper {
  _NearbyServiceAdvertiserDelegate(this._platform);

  final UwbIos _platform;

  @override
  void didNotStartAdvertisingPeer() {
    if (_platform.onAdvertisingFailure != null) {
      _platform.onAdvertisingFailure!();
    }
  }

  @override
  MCSessionWrapper? didReceiveInvitationFromPeer(
      MCPeerIDWrapper peerID, String? context) {
    //peerId van de advertiser
    final MCPeerIDWrapper peerId =
        MCPeerIDWrapper(displayName: peerID.displayName);
    final MCSessionWrapper mcSession = MCSessionWrapper(peerId: peerId);

    // _platform.onReceiveInvitation!(peerID.displayName!, context);
    return mcSession;
  }
}
