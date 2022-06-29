//
//  BFMCSessionHostApiImpl.swift
//  uwb_ios
//
//  Created by Leroy on 29/06/2022.
//

import Foundation
import MultipeerConnectivity

internal class BFMCSessionHostApiImpl : NSObject, BFMCSessionHostApi{

    let flutterMessenger: FlutterBinaryMessenger
    
    init(flutterMessenger: FlutterBinaryMessenger) {
        self.flutterMessenger = flutterMessenger
    }
    
    func createInstanceId(_ instanceId: NSNumber, mcPeerIDInstanceId: NSNumber, encryptionPreference: BFMCEncryptionPreferenceWrapper, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
        let mcSession = MCSession(peer: BFInstanceManager.current.getInstance(instanceId: mcPeerIDInstanceId) as! MCPeerID, securityIdentity: nil, encryptionPreference:    BFObjectTranslator.toMCEncryptionPreference(encryptionPreferenceWrapper: encryptionPreference))
        
        BFInstanceManager.current.addInstance(instanceId: instanceId, instance: mcSession)
    }
    
    func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let _ = BFInstanceManager.current.removeInstanceId(instanceId: instanceId)
    }
}
