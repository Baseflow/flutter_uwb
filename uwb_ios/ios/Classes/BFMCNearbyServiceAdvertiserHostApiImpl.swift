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
    
    init(flutterMessenger: FlutterBinaryMessenger) {
        self.flutterMessenger = flutterMessenger
    }
    
    func registerDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
//        let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi = BFMCNearbyServiceAdvertiserDelegateFlutterApi(binaryMessenger: flutterMessenger)
        let delegate: NearbyServiceAdvertiserDelegate = NearbyServiceAdvertiserDelegate()
        
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.delegate = delegate as MCNearbyServiceAdvertiserDelegate
    }
    
    func removeDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.delegate = nil
    }
    
    func createInstanceId(_ instanceId: NSNumber, mcPeerIDInstanceId: NSNumber, info: [String : String]?, serviceType: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
            peer: BFInstanceManager.current.getInstance(instanceId: mcPeerIDInstanceId) as! MCPeerID,
            discoveryInfo: info,
            serviceType: serviceType)

        BFInstanceManager.current.addInstance(instanceId: instanceId, instance: advertiser)
    }
    
    func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let _ = BFInstanceManager.current.removeInstanceId(instanceId: instanceId)
    }
    
    func startAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.startAdvertisingPeer()
    }
    
    func stopAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.stopAdvertisingPeer()
    }
}


internal class NearbyServiceAdvertiserDelegate : NSObject, MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("PRINT: I WORK!")
    }
    
//    let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi
//
//    init(flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi) {
//        self.flutterApi = flutterApi
//    }
//
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        let peerIdWrapper: BFMCPeerIDWrapper = BFMCPeerIDWrapper.make(withDisplayName: peerID.displayName)
//
//        var encodedContext: String?
//        if context != nil {
//            encodedContext = context?.base64EncodedString()
//        }
//
//        flutterApi.didReceiveInvitation(fromPeerPeerID: peerIdWrapper, context: encodedContext, completion: {(sessionWrapper: BFMCSessionWrapper?, error: Error?) in
//            if sessionWrapper == nil || error != nil {
//                invitationHandler(false, nil)
//                return
//            }
//
//            let session: MCSession = BFObjectTranslator.toMCSession(sessionWrapper: sessionWrapper!)
//            invitationHandler(true, session)
//        })
//    }
}



