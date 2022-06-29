//
//  BFObjectTranslator.swift
//  uwb_ios
//
//  Created by Leroy on 24/06/2022.
//

import Foundation
import MultipeerConnectivity

class BFObjectTranslator {
    static func toMCPeerID(peerIDWrapper: BFMCPeerIDWrapper) -> MCPeerID {
        return MCPeerID(displayName: peerIDWrapper.displayName ?? UIDevice.current.name)
    }
    
    static func toMCSession(sessionWrapper: BFMCSessionWrapper) -> MCSession {
        return MCSession(
            peer: toMCPeerID(peerIDWrapper: sessionWrapper.peerId!),
            securityIdentity: nil,
            encryptionPreference: toMCEncryptionPreference(encryptionPreferenceWrapper: sessionWrapper.encryptionPreference)
        )
    }
    
    static func toMCEncryptionPreference(encryptionPreferenceWrapper: BFMCEncryptionPreferenceWrapper) -> MCEncryptionPreference {
        switch encryptionPreferenceWrapper {
        case BFMCEncryptionPreferenceWrapper.optional:
            return MCEncryptionPreference.optional
        case BFMCEncryptionPreferenceWrapper.required:
            return MCEncryptionPreference.required
        default:
            return MCEncryptionPreference.none
        }
    }
}
