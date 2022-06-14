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
    
    func test_WHEN_authenticateIsCalled_THEN_authorizeCalledShouldBeTrue() {
        sut.authenticate { _ in
        } onError: { _ in
        }
        XCTAssertTrue(fakeOauth2Swift.authorizeWasCalled)
    }
    
    func test_WHEN_authenticateIsCalled_GIVEN_oauth2SwiftSucceded_THEN_itShouldCallSuccess() {
        fakeOauth2Swift.success = true
        let expectation = XCTestExpectation(description: "It should call success")
        sut.authenticate { token in
            expectation.fulfill()
        } onError: { _ in
            XCTFail()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_authenticateIsCalled_GIVEN_oauth2SwiftFailed_THEN_itShouldCalledOnError() {
        fakeOauth2Swift.success = false
        let expectation = XCTestExpectation(description: "It should call onError")
        sut.authenticate { _ in
            XCTFail()
        } onError: { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
}
