import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class UwbPlatform extends PlatformInterface{
  /// Constructs a UwbPlatform.
  UwbPlatform() : super(token: _token);

  static final Object _token = Object();

  /// The instance of [InAppPurchasePlatform] to use.
  /// Must be set before accessing.
  static UwbPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [UwbPlatform] when they register themselves.
  /// https://github.com/flutter/flutter/issues/43368
  static set instance(UwbPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Should only be accessed after setter is called.
  static late UwbPlatform _instance;

  /// Must be called once for initial setUp
  Future <bool?> setUp() => throw UnimplementedError("setUp() has not been implemented.");

  ///Starts the advertiser
  Future <bool?> startHost() => throw UnimplementedError('startHost() has not been implemented.');

  ///Sends an invite to peer
  Future <bool?> joinHost() => throw UnimplementedError("joinHost() has not been implemented.");

  ///Callback method to get the location updates
  Future <bool?> getLocation({required Function(Map) onLocation}) => throw UnimplementedError("getLocation() has not been implemented.");
}

