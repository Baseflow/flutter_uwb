//
//  BFMCPeerIDHostApiImpl.swift
//  uwb_ios
//
//  Created by Leroy on 29/06/2022.
//

import Foundation
import MultipeerConnectivity

internal class BFMCPeerIDHostApiImpl : NSObject, BFMCPeerIDHostApi{

    let flutterMessenger: FlutterBinaryMessenger
    
    init(flutterMessenger: FlutterBinaryMessenger) {
        self.flutterMessenger = flutterMessenger
    }
    
    func createInstanceId(_ instanceId: NSNumber, displayName: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let peerId = MCPeerID(displayName: displayName)
        print("PRINT: PEER ID ADDED")
        
        BFInstanceManager.current.addInstance(instanceId: instanceId, instance: peerId)
    }
    
    func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let _  = BFInstanceManager.current.removeInstanceId(instanceId: instanceId)
    }
}
