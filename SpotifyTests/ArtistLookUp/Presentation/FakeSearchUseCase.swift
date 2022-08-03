//
//  FakeSearchUseCase.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 8/07/22.
//

import Foundation
@testable import gndjf


class FakeSearchUseCase: SearchUseCaseProtocol {
    
    var searchWasExecuted = false
    var successCase = true
    
    func executeSearch(lookUp artist: String?, onSuccess: @escaping ([ArtistInformation]) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        
        searchWasExecuted = true
               
        if successCase {
            let artistInfo = ArtistInformation(id: "Foo ID", images: [ArtistImages(height: 1, width: 1, url: "Foo URL")], name: "Foo Artitst", popularity: 1, genres: ["Foo Genre"])
            onSuccess([artistInfo])
        } else {
            onError(WebServiceError.searchFailed)
        }
    }
    
}

