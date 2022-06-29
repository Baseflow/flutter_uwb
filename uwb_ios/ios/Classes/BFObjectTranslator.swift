//
//  BFObjectTranslator.swift
//  uwb_ios
//
//  Created by Leroy on 24/06/2022.
//

import Foundation
import MultipeerConnectivity

class BFObjectTranslator {
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
