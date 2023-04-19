//
//  FakeArtistLookUpService.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 2/08/22.
//

import Foundation
@testable import gndjf

class FakeArtistLookUpService: ArtistLookUpServiceProtocol {
    
    var successCase = false
    
    func getArtistInformation(artist: String, onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        if successCase {
            let artistImages = [ArtistImages(height: 1, width: 1, url: "Foo URL")]
            let artistInfo = ArtistInformation(id: "Foo ID", images: artistImages, name: "Foo Artitst", popularity: 1, genres: ["Foo Genre"])
            let pagination = Pagination(items: [artistInfo], href: nil, next: nil)
            onSuccess(ArtistLookUpAPIResponse(artists: pagination))
        } else {
            onError(.searchFailed)
        }
    }
    
   
}
