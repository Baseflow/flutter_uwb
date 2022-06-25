import 'dart:async';

import 'package:uwb_ios/setup_helper_class.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

import 'multipeer_connectivity_wrapper.dart';

/// Extends UwbPlatform. Directs method calls to the corresponding wrapper and helper classes
class UwbIos extends UwbPlatform {
  /// Sets the UbwPlatform instance
  static void registerWith() {
    UwbPlatform.instance = UwbIos();
  }

  /// Initialises the setupHelperClass
  SetupHelperClass setupHelperClass = SetupHelperClass();

  @override
  Future<bool> checkPlatformCompatibility() {
    /// Checks device iOS-version & UWB compatibility
    /// returns (true) if compatible
    return setupHelperClass.checkPlatformCompatibility();
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
    return super.joinHost(peerID, serviceType);
  }

  // @override
  // Future<bool?> getLocation(
  //     {required Function(Map<dynamic, dynamic>) onLocation}) {
  //   return super.getLocation(onLocation: onLocation);
  // }
}
