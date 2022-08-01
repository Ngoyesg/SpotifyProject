//
//  SpotifyURLBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 26/07/22.
//

import XCTest
@testable import gndjf
/*
class SpotifyURLBuilderTests: XCTestCase {

    private var sut: SpotifyURLBuilder!
    
    override func setUp() {
        super.setUp()
        sut = SpotifyURLBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildURLisInvoked_GIVEN_nilSearchAndArtistType_THEN_itShouldThrowErrorEmptyRequest(){
        
        do {
            let url = try sut.buildURL(for: nil, type: .artist)
            XCTFail()
        } catch let errorThrown {
            XCTAssertEqual(errorThrown as! SpotifyURLBuilder.Error, SpotifyURLBuilder.Error.emptyRequest)
        }
    }
    
    func test_WHEN_buildURLisInvoked_GIVEN_validSearchAndArtistType_THEN_itShouldThrowURLContainingSearch(){
        
        let searchFor = "David Bowie"
        do {
            let url = try sut.buildURL(for: searchFor, type: .artist)
            XCTAssertEqual(url, URL(string: "https://api.spotify.com/v1/search?q=David%20Bowie&type=artist"))
        } catch {
            XCTFail()
        }
    }
    
}
*/
