//
//  SpotifyURLRequestBuilderTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 26/07/22.
//

import XCTest
@testable import gndjf


class SpotifyURLRequestBuilderTests: XCTestCase {

    private var sut: URLRequestBuilder!
    
    override func setUp() {
        super.setUp()
        sut = URLRequestBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
 
    func test_WHEN_buildRequestisInvoked_GIVEN_someValidURLLikeDavidBowieSearch_THEN_itShouldReturnURLRequest(){
        
        let anyToken = "FooToken"
        let validURL = URL(string: "https://api.spotify.com/v1/search?q=David%20Bowie&type=artist")
        let expectedRequest = URLRequest(authorization: anyToken, for: validURL!)
        
        do {
            let validSearch = "David Bowie"
            let validQueryType = QueryType.artist
            let urlRequest = try sut.buildRequest(for: validSearch, type: validQueryType, authorization: anyToken)
            XCTAssertEqual(urlRequest, expectedRequest)
        } catch {
            XCTFail()
        }
    }


    func test_WHEN_buildRequestisInvoked_GIVEN_nilIdToSearch_THEN_itShouldThrowEmptySearchError(){
        do {
            let invalidSearch: String? = nil
            let validQueryType = QueryType.artist
            let anyToken = "FooToken"
            let urlRequest = try sut.buildRequest(for: invalidSearch, type: validQueryType, authorization: anyToken)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! URLRequestBuilder.Error, URLRequestBuilder.Error.emptyRequest)
        }
    }
    
    /*
    func test_WHEN_getRequestisInvoked_GIVEN_someInvalidURL_THEN_itShouldThrowUnauthorizedRequest(){
        do {
            let validURL = URL(string: "https://api.spotify.com/v1/search?q=David%20Bowie&type=artist")
            var urlRequest = try sut.getURLRequest(for: validURL)
            urlRequest.setValue(nil, forHTTPHeaderField: "Authorization")
        } catch {
            XCTAssertEqual(error as! SpotifyURLRequestBuilder.Error, SpotifyURLRequestBuilder.Error.unauthorizedRequest)
        }
    }
    
    func test_WHEN_getRequestisInvoked_GIVEN_someInvalidURL_THEN_itShouldThrowBuildingRequestFailed(){
        do {
            let validURL = URL(string: "https://api.spotify.com/v1/search?q=David%20Bowie&type=artist")
            var urlRequest = try sut.getURLRequest(for: validURL)
            urlRequest.setValue(nil, forHTTPHeaderField: "invalid header")
        } catch {
            XCTAssertEqual(error as! SpotifyURLRequestBuilder.Error, SpotifyURLRequestBuilder.Error.buildingRequestFailed)
        }
    }
    */
}


