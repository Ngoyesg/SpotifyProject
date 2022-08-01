//
//  KeychainFetchManagerTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/07/22.
//

import XCTest
@testable import gndjf

class KeychainFetchManagerTests: XCTestCase {

    private var sut: KeychainFetchManager!
    private var keychainSaver: KeychainSaveManager!
    
    override func setUp() {
        super.setUp()
        sut = KeychainFetchManager()
        keychainSaver =  KeychainSaveManager()
    }
    
    override func tearDown() {
        keychainSaver = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_fetchIsCalled_aTokenSaved_THEN_itShouldReturnSuchToken() {
       let anyTestableToken = "testableToken"
        keychainSaver.saveToken(token: anyTestableToken)
        let returnable = sut.fetchToken()
        XCTAssertEqual(anyTestableToken, returnable)
    }

}
