import 'dart:async';

import 'package:uwb_ios/mc_peer_id_wrapper_api_impl.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';
import 'mc_nearby_service_advertiser_wrapper.dart';

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
    MCPeerIDWrapperImpl mcPeerIDInstance = MCPeerIDWrapperImpl();
    mcPeerIDInstance.createfromInstance(peerID);

    final MCNearbyServiceAdvertiserWrapper advertiser =
        MCNearbyServiceAdvertiserWrapper(
      mcPeerIDInstance: mcPeerIDInstance,
      serviceType: serviceType,
    );

    advertiser.setDelegate(_NearbyServiceAdvertiserDelegate(this));

    return advertiser.startAdvertisingPeer();
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
}
