//
//  ArtistLookUpPresenterTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 30/06/22.
//
/*

import XCTest
@testable import gndjf

class ArtistLookUpPresenterTests: XCTestCase {
    
    private var sut: ArtistLookUpPresenter!
    var fakeViewController: FakeArtistLookUpViewController!
        
    override func setUp() {
        super.setUp()
        let fakeSearchUseCase = FakeSearchUseCase()
        fakeViewController = FakeArtistLookUpViewController()
        sut = ArtistLookUpPresenter(searchUseCase: fakeSearchUseCase)
        sut.setViewController(fakeViewController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_processSearchIsInvoked_GIVEN_emptyTextFieldAndViewControllerSetUp_THEN_itShouldAlertUser() {
        let emptyText: String? = nil
        sut.processSearch(artistName: emptyText)
        XCTAssertTrue(fakeViewController.alertWasInitialized)
    }
    
    func test_WHEN_processSearchIsInvoked_GIVEN_aValidTextFieldAndViewControllerSetUp_THEN_itShouldNavigateToNextScreen() {
        let emptyText: String? = "anyString"
        sut.processSearch(artistName: emptyText)
        XCTAssertTrue(fakeViewController.navigationWasInitialized)
    }

}
*/
