import 'package:flutter/services.dart';

class MCSessionWrapper {
  static const MethodChannel _channel = MethodChannel('com.baseflow.uwb/mc_session');
  static const MethodChannel _tokenChannel = MethodChannel('com.baseflow.uwb/mc_session_token');
  var methodCallHandler = false;

  setMethodcallHanderl() {
    methodCallHandler = true;
    _tokenChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<String> startMCSession() async {
    print("MCSessionWrapper - startMCSession() called");
    final String? status = await _channel.invokeMethod('MCSession.start');
    return status ?? "";
  }

  Future<bool?> startHost() async {
    if (!methodCallHandler){
      setMethodcallHanderl();
    }
    setMethodcallHanderl();
    print("Multipeer - startHost() called");
    final bool? hostingProcess = await _channel.invokeMethod('MCSession.startHost');
    return hostingProcess;
  }

  Future<bool?> joinHost() async {
    if (!methodCallHandler){
      setMethodcallHanderl();
    }
    print("Multipeer - joinHost() called");
    final bool? joiningProcess = await _channel.invokeMethod('MCSession.joinHost');
    return joiningProcess;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch(call.method) {
      case "token":
        final String location = call.arguments;
        print("token: "+ call.arguments);
        // _onLocation(location);
        break;
      default:
      //TODO: throw exception
    }
  }
}