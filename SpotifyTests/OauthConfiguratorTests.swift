//
//  OauthConfiguratorTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 13/06/22.
//

import XCTest
@testable import gndjf

class OauthConfiguratorTests: XCTestCase {

    private var sut: OauthConfigurator!
    
    override func setUp() {
        super.setUp()
        sut = OauthConfigurator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getAuthentifierIsExecuted_GIVEN_someValidParams_THEN_itShouldReturnOauth2Swift() {
        let fakeSpotifyAuthParams = SpotifyAuthParams(consumerKey: "dummy", consumerSecret: "dummy", authorizeUrl: "dummy", accessTokenUrl: "dummy", responseType: "dummy")
        let _ = sut.getAuthentifier(with: fakeSpotifyAuthParams)
    }
}
