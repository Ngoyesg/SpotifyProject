//
//  ArtistLookUpPresenterTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 30/06/22.
//


import XCTest
@testable import gndjf

class ArtistLookUpPresenterTests: XCTestCase {
    
    private var sut: ArtistLookUpPresenter!
    private var fakeSearchUseCase: FakeSearchUseCase!
    private var fakeViewController: FakeArtistLookUpViewController!
        
    override func setUp() {
        super.setUp()
        fakeSearchUseCase = FakeSearchUseCase()
        fakeViewController = FakeArtistLookUpViewController()
        sut = ArtistLookUpPresenter(searchUseCase: fakeSearchUseCase)
    }
    
    override func tearDown() {
        sut = nil
        fakeViewController = nil
        fakeSearchUseCase = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsInvoked_GIVEN_aValidViewController_THEN_propertyShouldNotBeNil(){
        let fakeViewController = FakeArtistLookUpViewController()
        sut.setViewController(fakeViewController)
        XCTAssertNotNil(sut.viewController)
    }
   
    func test_WHEN_processSearchIsInvoked_GIVEN_anyArtist_THEN_searchWasExecutedShouldBeTrue() {
        let anyArtistSearch: String? = "Foo Artist"
        sut.processSearch(artistName: anyArtistSearch)
        XCTAssertTrue(fakeSearchUseCase.searchWasExecuted)
    }
    
    func test_WHEN_processSearchIsInvoked_GIVEN_successfulSearchAndViewControllerSet_THEN_navigationWasInitializedShouldBeTrue() {
        
        sut.setViewController(fakeViewController)
        let anyArtistSearch: String? = "Foo Artist"
        fakeSearchUseCase.successCase = true
        sut.processSearch(artistName: anyArtistSearch)
        XCTAssertTrue(fakeViewController.navigationWasInitialized)
    }
  
    
    func test_WHEN_processSearchIsInvoked_GIVEN_failedSearchAndViewControllerSet_THEN_alertWasIntializedShouldBeTrue() {
        
        sut.setViewController(fakeViewController)
        let anyArtistSearch: String? = "Foo Artist"
        fakeSearchUseCase.successCase = false
        sut.processSearch(artistName: anyArtistSearch)
        XCTAssertTrue(fakeViewController.alertWasInitialized)
    }
}

