//
//  ArtistLookUpPresenterBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/07/22.
//

import XCTest
@testable import gndjf

class ArtistLookUpPresenterBuilderTests: XCTestCase {
    
    private var sut: ArtistLookUpPresenterBuilder!
    
    override func setUp() {
        sut = ArtistLookUpPresenterBuilder()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildWasInvoked_THEN_itShouldReturnLandingPresenter() {
        
        do {
            let presenter = try sut.build()
            XCTAssertTrue(presenter is ArtistLookUpPresenter)
        } catch {
            XCTFail()
        }
    }
    
}

