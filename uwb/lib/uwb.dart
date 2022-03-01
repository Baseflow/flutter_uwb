library uwb;

import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// A Calculator.
class Uwb {
  /// Must be called once for initial setUp
  Future <bool?> setUp() {
    return UwbPlatform.instance.setUp();
  }

  ///Starts the advertiser
  Future <bool?> startHost(){
    return UwbPlatform.instance.startHost();
  }

  ///Sends an invite to peer
  Future <bool?> joinHost(){
    return UwbPlatform.instance.joinHost();
  }

  ///Callback method to get the location updates
  Future <bool?> getLocation({required Function(String) onLocation }){
    return UwbPlatform.instance.getLocation(onLocation: onLocation);
  }
}
