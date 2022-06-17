//
//  LandingPresenterBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 15/06/22.
//

import XCTest
@testable import gndjf

class LandingPresenterBuilderTests: XCTestCase {

    private var sut: LandingPresenterBuilder!
    
    override func setUp() {
        super.setUp()
        sut = LandingPresenterBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildWasInvoked_THEN_itShouldReturnLandingPresenter() {
        do {
            let presenter = try sut.build()
            XCTAssertTrue(presenter is LandingPresenter)
        } catch {
            XCTFail()
        }
    }
    
}
