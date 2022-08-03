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
    var fakeArtistLookUpService: FakeArtistLookUpService!
    
    override func setUp() {
        super.setUp()
        fakeArtistLookUpService = FakeArtistLookUpService()
        sut = SearchUseCase(artistLookUpService: fakeArtistLookUpService)
    }
    
    override func tearDown() {
        sut = nil
        fakeArtistLookUpService = nil
        super.tearDown()
    }
    
    func test_WHEN_executeIsInvoked_GIVEN_anEmptyParameter_THEN_itShouldThrowInvalidSearchError() {
        
        let emptyParameter: String? = nil
       
        sut.executeSearch(lookUp: emptyParameter) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.invalidRequest)
        }
    }

    func test_WHEN_executeIsInvoked_GIVEN_successSearchCase_THEN_onSuccessShouldBeCalled() {
        
        let anyValidString = "anyString"
        fakeArtistLookUpService.successCase = true
        
        let artistImages = [ArtistImages(height: 1, width: 1, url: "Foo URL")]
        let artistInfo = ArtistInformation(id: "Foo ID", images: artistImages, name: "Foo Artitst", popularity: 1, genres: ["Foo Genre"])
        let expectedDataToReturn = [artistInfo]
        
        sut.executeSearch(lookUp: anyValidString) { returningData in
            XCTAssertEqual(returningData, expectedDataToReturn)
        } onError: { _ in
            XCTFail()
        }
    }
        
    func test_WHEN_executeIsInvoked_GIVEN_failedSearchCase_THEN_onSuccessShouldBeCalled() {
        
        let anyValidString = "anyString"
        fakeArtistLookUpService.successCase = false
        
        sut.executeSearch(lookUp: anyValidString) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
}

