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

  Future <bool?> setUp() async{
    final bool? status = await _channel.invokeMethod("NISession.setUp");
    if (methodCallHandler != status){
      setMethodcallHanderl();
    }
    return status ?? false;
  }

  Future<bool?> getLocation({required Function(String) onLocation }) async {
    _onLocation = onLocation;
    return true;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch(call.method) {
      case "updateLocation":
        print(call.arguments);
        final String location = call.arguments;
        _onLocation(location);
        break;
      default:
      //TODO: throw exception
    }
  }
}