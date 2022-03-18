import 'package:flutter/services.dart';

import '../instance_manager.dart';
import 'multipeer_connectivity_wrapper.dart';
import 'multipeer_connectivity_wrapper_api.pigeon.dart';

/// Implementation of the [MCNearbyServiceAdvertiserHostApi] interface. The
/// implementation is responsible for communicating with the native platform.
class MCNearbyServiceAdvertiserHostApiImpl
    extends MCNearbyServiceAdvertiserHostApi {
  /// Constructs a [MCNearbyServiceAdvertiserHostApiImpl].
  MCNearbyServiceAdvertiserHostApiImpl({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? InstanceManager.instance,
        super(binaryMessenger: binaryMessenger);

  /// Maintains instances stored to communicate with java objects.
  final InstanceManager instanceManager;

  /// Helper method to convert instance identifiers to objects.
  Future<void> createFromInstance(
      MCNearbyServiceAdvertiserWrapper instance,
      MCPeerIDWrapper peerId,
      Map<String?, String?>? info,
      String serviceType) async {
    final int? instanceId = instanceManager.tryAddInstance(instance);
    if (instanceId != null) {
      return create(
        instanceId,
        peerId,
        info,
        serviceType,
      );
    }
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> disposeFromInstance(
      MCNearbyServiceAdvertiserWrapper instance) async {
    final int? instanceId = instanceManager.removeInstance(instance);
    if (instanceId != null) {
      return dispose(instanceId);
    }
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> registerDelegateFromInstance(
      MCNearbyServiceAdvertiserWrapper instance) {
    return registerDelegate(instanceManager.getInstanceId(instance)!);
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> removeDelegateFromInstance(
      MCNearbyServiceAdvertiserWrapper instance) {
    return removeDelegate(instanceManager.getInstanceId(instance)!);
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> startAdvertisingPeerFromInstance(
      MCNearbyServiceAdvertiserWrapper instance) {
    return startAdvertisingPeer(instanceManager.getInstanceId(instance)!);
  }

  /// Helper method to convert instance identifiers to objects.
  Future<void> stopAdvertisingPeerFromInstance(
      MCNearbyServiceAdvertiserWrapper instance) {
    return stopAdvertisingPeer(instanceManager.getInstanceId(instance)!);
  }
}
