import 'package:uwb_ios/mc_peer_id_wrapper.dart';
import 'package:uwb_ios/mc_session_wrapper.dart';

import 'uwb_api.pigeon.dart';
import 'package:flutter/services.dart';
import 'package:uwb_ios/instance_manager.dart';

/// Implementation of the [MCSessionHostApiImpl] interface.
class MCSessionHostApiImpl extends MCSessionHostApi {
  /// Constructs a [MCSessionHostApiImpl].
  MCSessionHostApiImpl({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? InstanceManager.instance,
        super(binaryMessenger: binaryMessenger);

  /// Maintains instances stored to communicate with objects.
  final InstanceManager instanceManager;

  /// Initializes a MCSession object.
  Future<void> createFromInstance(
      MCSessionWrapper mcSessionWrapperInstance,
      MCPeerIDWrapper mcPeerIDWrapperInstance,
      MCEncryptionPreferenceWrapper mcEncryptionPreferenceWrapper) async {
    final int? instanceId =
        instanceManager.tryAddInstance(mcSessionWrapperInstance);
    return create(
        instanceId!,
        instanceManager.getInstanceId(mcPeerIDWrapperInstance)!,
        mcEncryptionPreferenceWrapper);
  }

  /// Discards the instance of the MCSession.
  Future<void> disposeFromIntstance(
      MCSessionWrapper mcPeerIDWrapperInstance) async {
    return dispose(instanceManager.getInstanceId(mcPeerIDWrapperInstance)!);
  }
}
