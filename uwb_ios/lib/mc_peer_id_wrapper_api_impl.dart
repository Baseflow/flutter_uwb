import 'uwb_api.pigeon.dart';
import 'package:flutter/services.dart';
import 'package:uwb_ios/instance_manager.dart';

/// Implementation of the [MCPeerIDWrapperImpl] interface.
class MCPeerIDWrapperImpl extends MCPeerIDHostApi {
  /// Constructs a [MCPeerIDWrapperImpl].
  MCPeerIDWrapperImpl({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? InstanceManager.instance,
        super(binaryMessenger: binaryMessenger);

  /// Maintains instances stored to communicate with objects.
  final InstanceManager instanceManager;

  /// Initializes a MCPeerID object.
  Future<void> createfromInstance(String displayName) async {
    final int? instanceId = instanceManager.tryAddInstance(this);
    return create(instanceId!, displayName);
  }

  /// Discards the instance of the MCPeerID.
  Future<void> disposeFromIntstance() async {
    return dispose(instanceManager.getInstanceId(this)!);
  }
}
