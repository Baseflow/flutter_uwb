
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

  @override
  Future <int> addOne(int value) {
    print("UwbIOs - addOne called");
    return mCalculator.increment(value);
  }

  Future <String> startMCSession() {
    print("UwbIos - startMCSession() called");
    return mCSession.startMCSession();
  }

  Future <String> startNISession() {
    print("UwbIos - startNISession() called");
    return nISession.startNISession();
  }
}
