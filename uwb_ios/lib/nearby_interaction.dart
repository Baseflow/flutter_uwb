import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NISessionWrapper {
  late final Function(String) _onLocation;
  static const MethodChannel _channel = MethodChannel('com.baseflow.uwb/ni_session');
  static const MethodChannel _locationChannel = MethodChannel('com.baseflow.uwb/ni_session_location');

  var methodCallHandler = false;

  setMethodcallHanderl() {
    methodCallHandler = true;
    _locationChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future <String> setUp() async{
    if (!methodCallHandler){
      setMethodcallHanderl();
    }
    print("NISessionWrapper - startNISession() called");
    final String? status = await _channel.invokeMethod("NISession.setUp");
    return status ?? "";
  }

  Future<bool?> getLocation({required Function(String) onLocation }) async {
    _onLocation = onLocation;
    return true;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    print("nearby_interaction - method called");
    switch(call.method) {
      case "updateLocation":
        final String location = call.arguments;
        print("Location: "+ call.arguments);
        _onLocation(location);
        break;
      default:
      //TODO: throw exception
    }
  }
}