import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Contains all the calls that needs to be implemented in the platform specific
/// plugins.
abstract class UwbPlatform extends PlatformInterface {
  /// Constructs an [UwbPlatform].
  UwbPlatform() : super(token: _token);

  static final Object _token = Object();

  /// The instance of [UwbPlatform] to use.
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

  /// Starts advertising the service.
  ///
  /// The [name] which will be displayed to clients looking to connect.
  Future<void> startHost(String name, String serviceType) =>
      throw UnimplementedError('startHost() has not been implemented.');

  /// Starts the process to connect to an advertised service.
  Future<bool?> joinHost() =>
      throw UnimplementedError('joinHost() has not been implemented.');
}
