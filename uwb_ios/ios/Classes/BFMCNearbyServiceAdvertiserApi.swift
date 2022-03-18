//
//  MCNearbyServiceAdvertiserApi.swift
//  uwb_ios
//
//  Created by Maurits van Beusekom on 17/03/2022.
//

import Foundation
import MultipeerConnectivity

internal class BFMCNearbyServiceAdvertiserHostApiImpl : NSObject, BFMCNearbyServiceAdvertiserHostApi {
  let flutterMessenger: FlutterBinaryMessenger
  var advertiser: MCNearbyServiceAdvertiser?
  
  init(flutterMessenger: FlutterBinaryMessenger) {
    self.flutterMessenger = flutterMessenger
  }
  
  func createInstanceId(_ instanceId: NSNumber, peerId: BFMCPeerIDWrapper, info: [String : String]?, serviceType: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    BFInstanceManager.current.addInstance(instanceId: instanceId, instance: self)
        
    advertiser = MCNearbyServiceAdvertiser(
      peer: BFObjectTranslator.toMCPeerID(peerIDWrapper: peerId),
      discoveryInfo: info,
      serviceType: serviceType)
  }
  
  func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    let _ = BFInstanceManager.current.removeInstanceId(instanceId: instanceId)
  }
  
  func registerDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi = BFMCNearbyServiceAdvertiserDelegateFlutterApi(binaryMessenger: flutterMessenger)
    let delegate: NearbyServiceAdvertiserDelegate = NearbyServiceAdvertiserDelegate(
      flutterApi: flutterApi)
    
    advertiser?.delegate = delegate
  }
  
  func removeDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    advertiser?.delegate = nil
  }
  
  func startAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    advertiser?.startAdvertisingPeer()
  }
  
  func stopAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    advertiser?.stopAdvertisingPeer()
  }
  
  
}

internal class NearbyServiceAdvertiserDelegate : NSObject, MCNearbyServiceAdvertiserDelegate {
  let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi
  
  init(flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi) {
    self.flutterApi = flutterApi
  }
  
  // Incoming invitation request.  Call the invitationHandler block with YES
  // and a valid session to connect the inviting peer to the session.
  @available(iOS 7.0, *)
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    let peerIdWrapper: BFMCPeerIDWrapper = BFMCPeerIDWrapper.make(withDisplayName: peerID.displayName)
    
    var encodedContext: String?
    if context != nil {
      encodedContext = context?.base64EncodedString()
    }
    
    flutterApi.didReceiveInvitation(fromPeerPeerID: peerIdWrapper, context: encodedContext, completion: {(sessionWrapper: BFMCSessionWrapper?, error: Error?) in
      if sessionWrapper == nil || error != nil {
        invitationHandler(false, nil)
        return
      }
      
      let session: MCSession = BFObjectTranslator.toMCSession(sessionWrapper: sessionWrapper!)
      invitationHandler(true, session)
    })
  }

  
  // Advertising did not start due to an error.
  @available(iOS 7.0, *)
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    flutterApi.didNotStartAdvertisingPeer(completion: { _ in })
  }
}
