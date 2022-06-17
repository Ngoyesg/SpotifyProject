//
//  KeychainFetchManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 6/06/22.
//

import Foundation
import KeychainAccess

protocol KeychainFetchManagerProtocol: AnyObject {
    func fetchToken() -> String?
}

class KeychainFetchManager: KeychainFetchManagerProtocol {
    func fetchToken() -> String? {
        let keychain = Keychain(service:  Constants.bundleID)
        return keychain[Constants.spotifyKeychain]
    }
}
