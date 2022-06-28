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
        print("registering delegate")
        let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi = BFMCNearbyServiceAdvertiserDelegateFlutterApi(binaryMessenger: flutterMessenger)
        let delegate: NearbyServiceAdvertiserDelegate = NearbyServiceAdvertiserDelegate(
            flutterApi: flutterApi)
        
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.delegate = delegate
    }
    
    func removeDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.delegate = nil
    }
    
    func createInstanceId(_ instanceId: NSNumber, peerId: BFMCPeerIDWrapper, info: [String : String]?, serviceType: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        print("creating instance")
        let advertiser: MCNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
            peer: BFObjectTranslator.toMCPeerID(peerIDWrapper: peerId),
            discoveryInfo: info,
            serviceType: serviceType)
        
        BFInstanceManager.current.addInstance(instanceId: instanceId, instance: advertiser)
    }
    
    func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let _ = BFInstanceManager.current.removeInstanceId(instanceId: instanceId)
    }
    
    func startAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        print("started advertising")
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.startAdvertisingPeer()
    }
    
    func stopAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
        advertiser.stopAdvertisingPeer()
    }
}


internal class NearbyServiceAdvertiserDelegate : NSObject, MCNearbyServiceAdvertiserDelegate {
    
    let flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi
    
    init(flutterApi: BFMCNearbyServiceAdvertiserDelegateFlutterApi) {
        self.flutterApi = flutterApi
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("RECEIVED INVITATION")
    }
}

