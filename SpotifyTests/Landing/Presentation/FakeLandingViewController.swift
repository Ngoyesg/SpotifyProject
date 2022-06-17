//
//  FakeLandingViewController.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 15/06/22.
//

import Foundation
@testable import gndjf

class FakeLandingViewController: LandingViewControllerProtocol {
    
    var navigationWasInitialized = false
    var alertWasInitialized = false
    
    func navigateToMainScreen() {
        self.navigationWasInitialized = true
    }
    
    func alertAuthenticationFailed() {
        self.alertWasInitialized = true
    }
}
