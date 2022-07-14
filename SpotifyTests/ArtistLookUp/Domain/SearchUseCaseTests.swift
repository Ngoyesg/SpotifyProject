//
//  SearchUseCaseTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 8/07/22.
//

import XCTest
@testable import gndjf

class SearchUseCaseTests: XCTestCase {
    
    private var sut: SearchUseCase!
    
    override func setUp() {
        super.setUp()
        sut = SearchUseCase()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeIsInvoked_GIVEN_anEmptyParameter_THEN_itShouldCallOnError() {
        
        let expectation = XCTestExpectation(description: "onError was called")
        sut.execute(parameter: nil) {
            XCTFail()
        } onError: { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_WHEN_executeIsInvoked_GIVEN_anyValidString_THEN_itShouldCallOnSuccess() {
        
        let anyValidString = "anyString"
        let expectation = XCTestExpectation(description: "onSuccess was called")
        
        sut.execute(parameter: anyValidString) {
            expectation.fulfill()
        } onError: { _ in
            XCTFail()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    
}
