//
//  AuthUseCaseTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/06/22.
//

import XCTest
@testable import gndjf

class AuthUseCaseTests: XCTestCase {
    
    private var sut: AuthUseCase!
    private var fakeOauthManager: FakeOauthManager!
    private var fakeKeychainSaveManager: FakeKeychainSaveManager!
    
    override func setUp() {
        fakeOauthManager = FakeOauthManager()
        fakeKeychainSaveManager = FakeKeychainSaveManager()
        sut = AuthUseCase(oauthManager: fakeOauthManager, keychainSaveManager: fakeKeychainSaveManager)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        fakeKeychainSaveManager = nil
        fakeOauthManager = nil
        super.tearDown()
    }
    
    func test_WHEN_executeIsInvoked_THEN_authenticateWasCalledShouldBeTrue() {
        sut.execute {
        } onError: { _ in
        }
        XCTAssertTrue(fakeOauthManager.authenticateWasCalled)
    }
    
    func test_WHEN_executeIsInvoked_GIVEN_authenticateSucceded_THEN_itShouldCallSaveTokenAndOnSuccess() {
        
        let expectation = XCTestExpectation(description: "onSuccess was called")
        
        sut.execute {
            XCTAssertTrue(self.fakeKeychainSaveManager.saveTokenWasCalled)
            expectation.fulfill()
        } onError: { _ in
            XCTFail()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_WHEN_executeIsInvoked_GIVEN_authenticateFailed_THEN_itShouldCallOnError() {
        
        let expectation = XCTestExpectation(description: "onError was called")
        fakeOauthManager.success = false
        
        sut.execute {
            XCTFail()
        } onError: { error in
            XCTAssertEqual(error, AuthUseCase.Error.authenticationFailed)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
