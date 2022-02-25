library uwb;

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// A Calculator.
class Uwb {
  /// Returns [value] plus 1.
  Future <int> addOne(int value) {
    print("Uwb - addOne called");
    return UwbPlatform.instance.addOne(value);
  }

  Future <String> startMCSession() {
    print("Uwb - startMCSession() called");
    return UwbPlatform.instance.startMCSession();
  }

  Future <String> startNISession() {
    print("Uwb - startNISession() called");
    return UwbPlatform.instance.startNISession();
  }

  Future <bool?> startHost(){
    print("Uwb - startHost() called");
    return UwbPlatform.instance.startHost();
  }

  Future <bool?> joinHost(){
    print("Uwb - joinHost() called");
    return UwbPlatform.instance.joinHost();
  }

  Future <bool?> getLocation({required Function(String) onLocation }){
    print("Uwb - joinHost() called");
    return UwbPlatform.instance.getLocation(onLocation: onLocation);
  }
}
