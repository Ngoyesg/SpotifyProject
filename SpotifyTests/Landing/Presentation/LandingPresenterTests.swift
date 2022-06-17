//
//  LandingPresenterTests.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 15/06/22.
//

import XCTest
@testable import gndjf

class LandingPresenterTests: XCTestCase {

    private var sut: LandingPresenter!
    private var fakeAuthUseCase: FakeAuthUseCase!
    private var fakeLandingViewController: FakeLandingViewController!
    
    override func setUp() {
        fakeAuthUseCase = FakeAuthUseCase()
        fakeLandingViewController = FakeLandingViewController()
        sut = LandingPresenter(authUseCase: fakeAuthUseCase)
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        fakeAuthUseCase = nil
        super.tearDown()
    }
    
    func test_WHEN_processLoginClickedWasInvoked_THEN_itShouldCallExecuteAuthentication(){
        sut.processLoginClicked()
        XCTAssertTrue(fakeAuthUseCase.executeWasCalled)
    }
    
    func test_WHEN_processLoginClickedWasInvoked_GIVEN_viewControllerWasSetAndAuthenticationSucceded_THEN_itShouldNavigateToMainScreen() {
        sut.setViewController(fakeLandingViewController)
        sut.processLoginClicked()
        XCTAssertTrue(fakeLandingViewController.navigationWasInitialized)
    }
    
    func test_WHEN_processLoginClickedWasInvoked_GIVEN_viewControllerWasSetAndAuthenticationFailed_THEN_itShouldAlertUser() {
        fakeAuthUseCase.success = false
        sut.setViewController(fakeLandingViewController)
        sut.processLoginClicked()
        XCTAssertTrue(fakeLandingViewController.alertWasInitialized)
    }
    
    
}
