//
//  ArtistLookUpServiceTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 3/08/22.
//

import XCTest
@testable import gndjf

class ArtistLookUpServiceTests: XCTestCase {
    
    private var sut: ArtistLookUpService!
    private var fakeURLRequestBuilder: FakeURLRequestBuilder!
    private var fakeRestClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeRestClient = FakeRESTClient()
        fakeURLRequestBuilder = FakeURLRequestBuilder()
        sut = ArtistLookUpService(urlRequestBuilder: fakeURLRequestBuilder, restClient: fakeRestClient)
    }
    
    override func tearDown() {
        sut = nil
        fakeURLRequestBuilder = nil
        fakeRestClient = nil
        super.tearDown()
    }
    
    func getExpectedAPIResponse() -> ArtistLookUpAPIResponse {
        let artistImages = [ArtistImages(height: 1, width: 1, url: "Foo URL")]
        let artistInfo = ArtistInformation(id: "Foo ID", images: artistImages, name: "Foo Artitst", popularity: 1, genres: ["Foo Genre"])
        let items = [artistInfo]
        let pagination = Pagination(items: items, href: nil, next: nil)
        return ArtistLookUpAPIResponse(artists: pagination)
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_validURLRequestAndSuccessCaseRESTRequest_THEN_itReturnArtistAPIResponse() {
        
        let anyValidArtist = "Foo Artist"
        let expectedData = getExpectedAPIResponse()
        fakeRestClient.successCase = true
        
        sut.getArtistInformation(artist: anyValidArtist) { response in
            XCTAssertEqual(response, expectedData)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_validURLRequestAndFailedCaseRESTRequest_THEN_itReturnSearchFailedError() {
        
        let anyValidArtist = "Foo Artist"
        fakeRestClient.successCase = false
        
        sut.getArtistInformation(artist: anyValidArtist) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.invalidRequest)
        }
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_validURLRequestAndSuccessCaseRESTRequestAndUndecodableData_THEN_itReturnSearchFailedError() {
        
        let anyValidArtist = "Foo Artist"
        fakeRestClient.successCase = true
        fakeRestClient.decodableDataCase = false
        
        sut.getArtistInformation(artist: anyValidArtist) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.errorDecodingData)
        }
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_noEndpoint_THEN_itReturnNoEndpointFoundError() {
        
        let anyValidArtist = "Foo Artist"
        fakeURLRequestBuilder.noEndpointCase = true
        
        sut.getArtistInformation(artist: anyValidArtist) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.noEndpointFound)
        }
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_noURLFromEndpoint_THEN_itReturnNoURLFoundError() {
        
        let anyValidArtist = "Foo Artist"
        fakeURLRequestBuilder.noURLCase = true
        
        sut.getArtistInformation(artist: anyValidArtist) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.noURLFound)
        }
    }
    
    func test_WHEN_getArtistInformationIsInvoked_GIVEN_noTokenFound_THEN_itReturnUnauthorizedError() {
        
        let anyValidArtist = "Foo Artist"
        fakeURLRequestBuilder.unauthorizedCase = true
        
        sut.getArtistInformation(artist: anyValidArtist) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.unauthorizedRequest)
        }
    }
    
    
    
    
}
