import 'package:flutter/services.dart';

class NISessionWrapper {
  late final Function(Map) _onLocation;
  static const MethodChannel _locationChannel =
      MethodChannel('com.baseflow.uwb/ni_session_location');

  setUp() {
    _locationChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<bool?> getLocation({required Function(Map) onLocation}) async {
    _onLocation = onLocation;
    return true;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "updateLocation":
        final Map location = call.arguments;
        _onLocation(location);
        break;
      default:
      //TODO: throw exception
    }
  }
}
