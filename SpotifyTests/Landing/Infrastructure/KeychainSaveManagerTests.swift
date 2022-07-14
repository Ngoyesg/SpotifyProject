//
//  KeychainSaveManagerTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/07/22.
//

import XCTest
@testable import gndjf

class KeychainSaveManagerTests: XCTestCase {
    
    private var sut: KeychainSaveManager!
    private var fakeKeychainFetcher: KeychainFetchManager!
    
    override func setUp() {
        super.setUp()
        sut = KeychainSaveManager()
        fakeKeychainFetcher = KeychainFetchManager()
    }
    
    override func tearDown() {
        sut = nil
        fakeKeychainFetcher = nil
        super.tearDown()
    }
    
    func test_WHEN_fetchIsCalled_THEN_itShouldReturnSpotifyKey() {
        let anyValidToken = "testableValidToken"
        sut.saveToken(token: anyValidToken)
        let tokenFetched = fakeKeychainFetcher.fetchToken()
        XCTAssertEqual("testableValidToken", tokenFetched)
    }
    
}
