//
//  URLRequestBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 26/07/22.
//

import XCTest
@testable import gndjf

class URLRequestBuilderTests: XCTestCase {

    private var sut: URLRequestBuilder!
    private var fakeKeychainFetchManager: FakeKeychainFetchManager!
    
    override func setUp() {
        super.setUp()
        fakeKeychainFetchManager = FakeKeychainFetchManager()
        sut = URLRequestBuilder(keychainManager: fakeKeychainFetchManager)
    }

    override func tearDown() {
        sut = nil
        fakeKeychainFetchManager = nil
        super.tearDown()
    }
    
    func test_WHEN_setEndpointIsInvoked_GIVEN_someValidEndpoint_THEN_parameterShouldNotBeNil(){
        
        let anyValidEndpoint = ArtistEndpoint(search: "Foo artist")
        sut.setEndpoint(endpoint: anyValidEndpoint)
        XCTAssertTrue(sut.endpoint! is BaseEndpoint)
    }
    
    func test_WHEN_buildURLisInvoked_GIVEN_noEndpoint_THEN_itShouldThrowinvalidURLError() throws {

        do {
            let _ = try sut.build()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.noEndpoint)
        }
    }
    
    func test_WHEN_buildURLisInvoked_GIVEN_failingEndpoint_THEN_itShouldThrowinvalidURLError() throws {

        let anyInvalidEndpoint = BaseEndpoint(path: " ", queryItems: [], httpMethod: .GET)
        do {
            sut.setEndpoint(endpoint: anyInvalidEndpoint)
            let _ = try sut.build()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.noURL)
        }
    }

    func test_WHEN_buildURLisInvoked_GIVEN_validEndpointAndNoToken_THEN_itShouldThrowUnauthorizedError() throws {

        fakeKeychainFetchManager.errorCase = true
        let anyValidEndpoint = ArtistEndpoint(search: "Foo artist")

        do {
            sut.setEndpoint(endpoint: anyValidEndpoint)
            let _ = try sut.build()
            XCTFail()
        } catch let error {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.unauthorized)
        }
    }
    
    func test_WHEN_buildURLisInvoked_GIVEN_validEndpointAndToken_THEN_itShouldReturnURLRequest() throws {

        fakeKeychainFetchManager.errorCase = false
        let anyValidEndpoint = ArtistEndpoint(search: "Foo artist")

        do {
            sut.setEndpoint(endpoint: anyValidEndpoint)
            let urlRequest = try sut.build()
            XCTAssertTrue(urlRequest is URLRequest)
        } catch {
            XCTFail()
        }
    }
    
}

