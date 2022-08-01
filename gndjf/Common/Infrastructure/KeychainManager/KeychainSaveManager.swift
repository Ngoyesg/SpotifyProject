//
//  KeychainSaveManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 6/06/22.
//

import Foundation
import KeychainAccess

protocol KeychainSaveManagerProtocol: AnyObject {
    func saveToken(token: String)
}

class KeychainSaveManager: KeychainSaveManagerProtocol {
    func saveToken(token: String) {
        let keychain = Keychain(service: Constants.bundleID)
        keychain[Constants.spotifyKeychain] = token
    }
}
