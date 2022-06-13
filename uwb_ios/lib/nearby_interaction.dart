import 'package:flutter/services.dart';

/// Contains all the Nearby Interaction Framework calls
class NISessionWrapper {
  late final Function(Map<dynamic, dynamic>) _onLocation;
  static const MethodChannel _locationChannel =
      MethodChannel('com.baseflow.uwb/ni_session_location');

  /// Sets the method callHandler for the Nearby Interaction Session
  /// This needs to be set after the corresponding FlutterMethodChannel has been set in the native swift file
  void setUp() {
    _locationChannel.setMethodCallHandler(_handleMethodCall);
  }

  /// Callback method to get the location updates
  Future<bool?> getLocation(
      {required Function(Map<dynamic, dynamic>) onLocation}) async {
    _onLocation = onLocation;
    return true;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'updateLocation':
        final Map<dynamic, dynamic> location =
            call.arguments as Map<dynamic, dynamic>;
        _onLocation(location);
        break;
      default:
        throw MissingPluginException();
    }
  }
}
