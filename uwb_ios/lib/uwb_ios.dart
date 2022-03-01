
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:uwb_ios/math_calculator.dart';
import 'package:uwb_ios/multipeer_connectivity.dart';
import 'package:uwb_ios/nearby_interaction.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

class UwbIos extends UwbPlatform{
  static void registerWith(){
    UwbPlatform.instance = UwbIos();
  }

  var mCalculator = MCalculatorWrapper();
  var mCSession = MCSessionWrapper();
  var nISession = NISessionWrapper();

  Future <String> setUp() {
    return nISession.setUp();
  }

  Future <bool?> startHost() {
    return mCSession.startHost();
  }

  Future <bool?> joinHost() {
    return mCSession.joinHost();
  }

  Future <bool?> getLocation({required Function(String) onLocation }) {
    return nISession.getLocation(onLocation: onLocation);
  }
}
