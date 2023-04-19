//
//  ArtistDetailedPresenter.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import Foundation

protocol  ArtistDetailedPresenterProtocol: AnyObject {
    //func processArtistClicked()
    func setViewController(_ viewController: ArtistDetailedViewControllerProtocol)
    func setArtistsInformation(with artistsInfo: ArtistLookUpAPIResponse)
}

class ArtistDetailedPresenter {
    
    enum Error: Swift.Error {
        case loginFailed
    }
    
    weak var viewController: ArtistDetailedViewControllerProtocol?
    var artistsInfo: ArtistLookUpAPIResponse?
    
}

extension ArtistDetailedPresenter: ArtistDetailedPresenterProtocol {
    
    func setArtistsInformation(with artistsInfo: ArtistLookUpAPIResponse) {
        self.artistsInfo = artistsInfo
    }
    
    func setViewController(_ viewController: ArtistDetailedViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func getArtistInfoCount() -> Int? {
        return artistsInfo?.artists.items.count
    }
    
    func getArtisDetailedInfo(at row: Int) ->  artistinformation{
        return
    }
    
    
}

