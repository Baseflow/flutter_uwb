library uwb;

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// A Calculator.
class Uwb {
  /// Checks if the current platform supports Ultra Wide Band.
  ///
  /// Returns `true` if UWB is supported or `false` if UWB is not supported.
  Future<bool> setUp() {
    return UwbPlatform.instance.checkPlatformCompatibility();
  }

  /// Start advertising as a ultra wide band host allowing clients to connect.
  ///
  /// The [peerID] identifies a peer (the host in this case) in a multi peer session.
  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  Future<void> startHost(String peerID, String serviceType) {
    return UwbPlatform.instance.startHost(peerID, serviceType);
  }

  /// Sends an invite to the advertiser to start a multi peer session.
  ///
  /// The [peerID] identifies a peer (the client in this case) in a multi peer session.
  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  Future<void> joinHost(String peerID, String serviceType) {
    return UwbPlatform.instance.joinHost(peerID, serviceType);
  }

  ///Callback method to get the location updates
  Future<void> getLocation(
      {required Function(Map<dynamic, dynamic>) onLocation}) {
    return UwbPlatform.instance.getLocation(onLocation: onLocation);
  }
}
