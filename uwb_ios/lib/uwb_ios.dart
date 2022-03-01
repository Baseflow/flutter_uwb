
import 'dart:async';
import 'package:uwb_ios/multipeer_connectivity.dart';
import 'package:uwb_ios/nearby_interaction.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

class UwbIos extends UwbPlatform{
  static void registerWith(){
    UwbPlatform.instance = UwbIos();
  }

  var mCSession = MCSessionWrapper();
  var nISession = NISessionWrapper();

  @override
  Future <bool?> setUp() {
    return nISession.setUp();
  }

  @override
  Future <bool?> startHost() {
    return mCSession.startHost();
  }

  @override
  Future <bool?> joinHost() {
    return mCSession.joinHost();
  }

  @override
  Future <bool?> getLocation({required Function(String) onLocation }) {
    return nISession.getLocation(onLocation: onLocation);
  }
}
