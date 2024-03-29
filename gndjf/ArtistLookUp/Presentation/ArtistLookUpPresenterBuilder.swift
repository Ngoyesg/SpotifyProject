//
//  ArtistLookUpPresenterBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import Foundation

class ArtistLookUpPresenterBuilder {
    
    func build() -> ArtistLookUpPresenterProtocol {
        
        let keychainFetchManager = KeychainFetchManager()
        
        let URLRequestBuilder = URLRequestBuilder(keychainManager: keychainFetchManager)

        let RESTClient = RESTClient()

        let artistLookUpService = ArtistLookUpService(urlRequestBuilder: URLRequestBuilder, restClient: RESTClient)
        
        let searchUseCase = SearchUseCase(artistLookUpService: artistLookUpService)

        return ArtistLookUpPresenter(searchUseCase: searchUseCase)
    }
    
}
