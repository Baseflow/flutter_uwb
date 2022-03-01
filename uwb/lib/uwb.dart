library uwb;

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// A Calculator.
class Uwb {
  ///Needed for initial set-up
  Future <String> setUp() {
    print("Uwb - startNISession() called");
    return UwbPlatform.instance.setUp();
  }

  ///Start Advertising
  Future <bool?> startHost(){
    print("Uwb - startHost() called");
    return UwbPlatform.instance.startHost();
  }

  ///Invite Peer
  Future <bool?> joinHost(){
    print("Uwb - joinHost() called");
    return UwbPlatform.instance.joinHost();
  }

  ///Update location
  Future <bool?> getLocation({required Function(String) onLocation }){
    print("Uwb - joinHost() called");
    return UwbPlatform.instance.getLocation(onLocation: onLocation);
  }
}
