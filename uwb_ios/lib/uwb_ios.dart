import 'dart:async';
import 'package:uwb_ios/multipeer_connectivity.dart';
import 'package:uwb_ios/nearby_interaction.dart';
import 'package:uwb_ios/setup_helper_class.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

class UwbIos extends UwbPlatform {
  static void registerWith() {
    UwbPlatform.instance = UwbIos();
  }

  var mCSession = MCSessionWrapper();
  var nISession = NISessionWrapper();
  var setupHelperClass = SetupHelperClass();

  @override
  Future<bool?> setUp() {
    ///Sets the method callHandler for the NISession
    ///This needs to be set after the corresponding FlutterMethodChannel has been set in the native swift file
    nISession.setUp();

    ///Checks iOS-version & device UWB compatibility
    ///returns (true) if compatible
    return setupHelperClass.setUp();
  }

  @override
  Future<bool?> startHost() {
    return mCSession.startHost();
  }

  @override
  Future<bool?> joinHost() {
    return mCSession.joinHost();
  }

  @override
  Future<bool?> getLocation({required Function(Map) onLocation}) {
    return nISession.getLocation(onLocation: onLocation);
  }
}
