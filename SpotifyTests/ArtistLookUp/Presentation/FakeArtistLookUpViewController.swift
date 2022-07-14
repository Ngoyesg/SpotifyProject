//
//  FakeArtistLookUpViewController.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/07/22.
//

import Foundation
@testable import gndjf

class FakeArtistLookUpViewController: ArtistLookUpViewControllerProtocol {
    
    var navigationWasInitialized = false
    var alertWasInitialized = false
    
    func navigateToArtistDetail() {
        self.navigationWasInitialized = true
    }
    
    func alertSearchFailed() {
        self.alertWasInitialized = true
    }
    
}

