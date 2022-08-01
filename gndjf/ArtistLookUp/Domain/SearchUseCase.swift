//
//  SearchUseCase.swift
//  gndjf
//
//  Created by Natalia Goyes on 30/06/22.
//

import Foundation

protocol SearchUseCaseProtocol: AnyObject {
    func executeSearch(lookUp artist: String?, onSuccess: @escaping ([ArtistInformation]) -> (Void), onError: @escaping (WebServiceError) ->(Void))
}

class SearchUseCase {
    
    let artistLookUpService: ArtistLookUpServiceProtocol
    
    init(artistLookUpService: ArtistLookUpServiceProtocol) {
        self.artistLookUpService = artistLookUpService
    }
}

extension SearchUseCase: SearchUseCaseProtocol {
    func executeSearch(lookUp artist: String?, onSuccess: @escaping ([ArtistInformation]) -> (Void), onError: @escaping (WebServiceError) ->(Void)) {
        
        artistLookUpService.getArtistInformation(artist: artist) { [weak self] artistsInformation in
            guard let self = self else {
                return
            }
            onSuccess(artistsInformation.artists.items)
        } onError: { [weak self] webRequestError  in
            guard let self = self else {
                return
            }
            onError(webRequestError)
        }
    }
}
