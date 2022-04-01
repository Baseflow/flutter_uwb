import 'dart:async';

import 'package:uwb_ios/multipeer_connectivity.dart';
import 'package:uwb_ios/nearby_interaction.dart';
import 'package:uwb_ios/setup_helper_class.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// Extends UwbPlatform. Directs method calls to the corresponding wrapper and helper classes
class UwbIos extends UwbPlatform {
  /// Sets the UbwPlatform instance
  static void registerWith() {
    UwbPlatform.instance = UwbIos();
  }

  /// Initialises MCSessionWrapper
  MCSessionWrapper mCSession = MCSessionWrapper();

  /// Initialises NISessionWrapper
  NISessionWrapper nISession = NISessionWrapper();

  /// Initialises the setupHelperClass
  SetupHelperClass setupHelperClass = SetupHelperClass();

  @override
  Future<bool?> setUp() {
    /// Sets the method callHandler for the Nearby Interaction Session
    /// This needs to be set after the corresponding FlutterMethodChannel has been set in the native swift file
    nISession.setUp();

    /// Checks device iOS-version & UWB compatibility
    /// returns (true) if compatible
    return setupHelperClass.setUp();
  }

  @override
  Future<bool?> startHost(String peerID, String serviceType) {
    return mCSession.startHost(peerID, serviceType);
  }

  @override
  Future<bool?> joinHost(String peerID, String serviceType) {
    return mCSession.joinHost(peerID, serviceType);
  }

  @override
  Future<bool?> getLocation(
      {required Function(Map<dynamic, dynamic>) onLocation}) {
    return nISession.getLocation(onLocation: onLocation);
  }
}
