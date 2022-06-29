import 'package:uwb_ios/mc_peer_id_wrapper.dart';

import 'uwb_api.pigeon.dart';
import 'package:flutter/services.dart';
import 'package:uwb_ios/instance_manager.dart';

/// Implementation of the [MCPeerIDHostApiImpl] interface.
class MCPeerIDHostApiImpl extends MCPeerIDHostApi {
  /// Constructs a [MCPeerIDHostApiImpl].
  MCPeerIDHostApiImpl({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? InstanceManager.instance,
        super(binaryMessenger: binaryMessenger);

  /// Maintains instances stored to communicate with objects.
  final InstanceManager instanceManager;

  /// Initializes a MCPeerID object.
  Future<void> createFromInstance(
      MCPeerIDWrapper mcPeerIDWrapperInstance, String displayName) async {
    final int? instanceId =
        instanceManager.tryAddInstance(mcPeerIDWrapperInstance);
    return create(instanceId!, displayName);
  }

  /// Discards the instance of the MCPeerID.
  Future<void> disposeFromIntstance(
      MCPeerIDWrapper mcPeerIDWrapperInstance) async {
    return dispose(instanceManager.getInstanceId(mcPeerIDWrapperInstance)!);
  }
}
