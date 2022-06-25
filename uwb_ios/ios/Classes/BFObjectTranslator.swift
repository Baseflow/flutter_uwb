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
        return MCPeerID(displayName: peerIDWrapper.displayname ?? UIDevice.current.name)
    }
}
