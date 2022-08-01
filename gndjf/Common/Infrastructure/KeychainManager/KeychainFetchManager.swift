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

class KeychainFetchManager {
    
    enum Error: Swift.Error {
        case unauthorized
    }
    
}

extension KeychainFetchManager: KeychainFetchManagerProtocol {
    func fetchToken()  -> String? {
        let keychain = Keychain(service:  Constants.bundleID)
        let token = keychain[Constants.spotifyKeychain]
        return token
    }
}
