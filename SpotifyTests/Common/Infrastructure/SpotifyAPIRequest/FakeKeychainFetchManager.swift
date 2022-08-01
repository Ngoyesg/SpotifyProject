//
//  FakeKeychainFetchManager.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 28/07/22.
//

import Foundation
@testable import gndjf

class FakeKeychainFetchManager: KeychainFetchManagerProtocol {
        
    func fetchToken() -> String? {
        return "TokenExample"
    }

}
