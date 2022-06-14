//
//  FakeKeychainSaveManager.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/06/22.
//

import Foundation
@testable import gndjf

class FakeKeychainSaveManager: KeychainSaveManagerProtocol {
    
    var saveTokenWasCalled = false

    func saveToken(token: String) {
        saveTokenWasCalled = true
    }
}
