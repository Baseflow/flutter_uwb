library uwb;

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// A Calculator.
class Uwb {
  /// Must be called once for initial setUp
  Future<bool?> setUp() {
    return UwbPlatform.instance.setUp();
  }

  ///Starts the advertiser
  Future<bool?> startHost(String peerID, String serviceType) {
    return UwbPlatform.instance.startHost(peerID, serviceType);
  }

  ///Sends an invite to peer
  Future<bool?> joinHost(String peerID, String serviceType) {
    return UwbPlatform.instance.joinHost(peerID, serviceType);
  }

  ///Callback method to get the location updates
  Future<bool?> getLocation(
      {required Function(Map<dynamic, dynamic>) onLocation}) {
    return UwbPlatform.instance.getLocation(onLocation: onLocation);
  }
}
