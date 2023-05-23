//
//  OauthManagerTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/06/22.
//

import XCTest
@testable import gndjf

class OauthManagerTests: XCTestCase {
    
    private var sut: OauthManager!
    private var spotifyScopeParams: SpotifyScopeParams!
    private var fakeOauth2Swift: FakeOauth2Swift!
    
    override func setUp() {
        fakeOauth2Swift = FakeOauth2Swift(consumerKey: "dummy", consumerSecret: "dummy", authorizeUrl: "dummy", responseType: "dummy")
        spotifyScopeParams = SpotifyScopeParams(withCallbackURL: "dummy", scope: "dummy", state: 1)
        sut = OauthManager(oauth2Swift: fakeOauth2Swift, spotifyScopeParams: spotifyScopeParams)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        spotifyScopeParams = nil
        fakeOauth2Swift = nil
        super.tearDown()
    }
    
    func test_WHEN_authenticateIsCalled_THEN_authorizeShouldBeCalled() {
        //arrange
        let expectation = XCTestExpectation(description: "Authorize should be called")
        fakeOauth2Swift.authorizeWasCalledExpectation = expectation
        
        //act
        sut.authenticate { _, _ in
        }

        //assert
        self.wait(for: [expectation], timeout: 1)

    }
    
    func test_WHEN_authenticateIsCalled_GIVEN_oauth2SwiftSucceded_THEN_tokenShouldNotBeNilErrorShouldBeNil() {
        //arrange
        fakeOauth2Swift.success = true
        var retrivedToken: String? = nil
        var retrievedError: Error? = nil
        
        //act
        sut.authenticate { token, error in
            retrivedToken = token
            retrievedError = error
        }
        
        //assert
        XCTAssertNotNil(retrivedToken)
        XCTAssertNil(retrievedError)
    }
    
    func test_WHEN_authenticateIsCalled_GIVEN_oauth2SwiftFailed_THEN_tokenShouldBeNilErrorShouldBeMissingToken() {
        //arrange
        fakeOauth2Swift.success = false
        var retrivedToken: String? = nil
        var retrievedError: Error? = nil
        
        //act
        sut.authenticate { token, error in
            retrivedToken = token
            retrievedError = error
        }
        
        //assert
        XCTAssertNotNil(retrievedError)
        XCTAssertNil(retrivedToken)
    }
    
}
