//
//  FakeKeychainFetchManager.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 28/07/22.
//

import Foundation
@testable import gndjf

class FakeKeychainFetchManager: KeychainFetchManagerProtocol {
        
    var errorCase = false
    
    func fetchToken() -> String? {
        return (errorCase) ? nil : "tokenFoo"
    }

}
