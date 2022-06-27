import 'package:flutter/services.dart';
import 'package:uwb_ios/instance_manager.dart';
import 'package:uwb_ios/uwb_api.pigeon.dart';

import 'mc_browser_view_controller_wrapper.dart';

/// Implementation of the [MCBrowserViewControllerHostApiImpl] interface.
class MCBrowserViewControllerHostApiImpl
    extends MCBrowserViewControllerHostApi {
  /// Constructs a [MCBrowserViewControllerHostApiImpl].
  MCBrowserViewControllerHostApiImpl({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? InstanceManager.instance,
        super(binaryMessenger: binaryMessenger);

  /// Maintains instances stored to communicate with objects.
  final InstanceManager instanceManager;

  /// Helper method to convert instance identifiers to objects.
  Future<void> createFromInstance(MCBrowserViewControllerWrapper instance,
      MCSessionWrapper mcSession, String serviceType) async {
    print("MCBrowserViewControllerHostApiImpl - createFromInstance");
    final int? instanceId = instanceManager.tryAddInstance(instance);
    if (instanceId != null) {
      return create(instanceId, mcSession, serviceType);
    }
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> disposeFromInstance(
      MCBrowserViewControllerWrapper instance) async {
    final int? instanceId = instanceManager.removeInstance(instance);
    if (instanceId != null) {
      return dispose(instanceId);
    }
  }

  ///
  Future<void> presentTheBrowserToViewControllerFromInstance(
      MCBrowserViewControllerWrapper instance) async {
    print(
        "MCBrowserViewControllerHostApiImpl - presentTheBrowserToViewControllerFromInstance");
    final int? instanceId = instanceManager.removeInstance(instance);
    if (instanceId != null) {
      return presentTheBrowserToViewController(instanceId);
    }
  }
}
