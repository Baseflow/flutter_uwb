//
//  MCNearbyServiceAdvertiserApi.swift
//  uwb_ios
//
//  Created by Maurits van Beusekom on 17/03/2022.
//

import Foundation
import MultipeerConnectivity
import NearbyInteraction

internal class BFMCNearbyServiceAdvertiserHostApiImpl : NSObject, BFMCNearbyServiceAdvertiserHostApi {
    func registerDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func removeDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func stopAdvertisingPeerInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func createInstanceId(_ instanceId: NSNumber, peerId: BFMCPeerIDWrapper, info: [String : String]?, serviceType: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
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
        let advertiser: MCNearbyServiceAdvertiser = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCNearbyServiceAdvertiser
           advertiser.startAdvertisingPeer()
    }
    
  let flutterMessenger: FlutterBinaryMessenger
    
  init(flutterMessenger: FlutterBinaryMessenger) {
    self.flutterMessenger = flutterMessenger
  }
  
  public func checkPlatformCompatibilityWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
      if #available(iOS 14.0, *) {
          if NISession.isSupported {
              return true
          }
      }
    return false
  }
}
