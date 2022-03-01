import 'package:plugin_platform_interface/plugin_platform_interface.dart';
/// A Calculator.
abstract class UwbPlatform extends PlatformInterface{
  /// Constructs a InAppPurchasePlatform.
  UwbPlatform() : super(token: _token);

  static final Object _token = Object();

  /// The instance of [InAppPurchasePlatform] to use.
  ///
  /// Must be set before accessing.
  static UwbPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [InAppPurchasePlatform] when they register themselves.
  // TODO(amirh): Extract common platform interface logic.
  // https://github.com/flutter/flutter/issues/43368
  static set instance(UwbPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // Should only be accessed after setter is called.
  static late UwbPlatform _instance;

  /// Returns [value] plus 1.
  Future <int> addOne(int value) => throw UnimplementedError('addOne() has not been implemented.');

  Future <String> startMCSession() => throw UnimplementedError('startMCSession() has not been implemented.');

  Future <String> setUp() => throw UnimplementedError("startNISession() has not been implemented.");

  Future <bool?> startHost() => throw UnimplementedError('startMCSession() has not been implemented.');

  Future <bool?> joinHost() => throw UnimplementedError("startNISession() has not been implemented.");

  Future <bool?> getLocation({required Function(String) onLocation}) => throw UnimplementedError("startNISession() has not been implemented.");
}

