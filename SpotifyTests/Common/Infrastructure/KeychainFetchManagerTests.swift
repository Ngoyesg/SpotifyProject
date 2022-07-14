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
    private var fakeKeychainSaver: KeychainSaveManager!
    
    override func setUp() {
        super.setUp()
        sut = KeychainFetchManager()
        fakeKeychainSaver =  KeychainSaveManager()
    }
    
    override func tearDown() {
        fakeKeychainSaver = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_fetchIsCalled_aTokenSaved_THEN_itShouldReturnSuchToken() {
       let anyTestableToken = "testableToken"
        fakeKeychainSaver.saveToken(token: anyTestableToken)
        let returnable = sut.fetchToken()
        XCTAssertEqual(anyTestableToken, returnable)
    }

}
