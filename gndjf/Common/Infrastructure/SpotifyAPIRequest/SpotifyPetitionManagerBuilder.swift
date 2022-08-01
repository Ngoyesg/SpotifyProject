//
//  SpotifyPetitionManagerBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 28/07/22.
//

import Foundation

protocol SpotifyPetitionManagerBuilderProtocol: AnyObject {
    func sendRequest(for search: String?, type query: QueryType, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void)
}

class SpotifyPetitionManagerBuilder {
    
    enum Error: Swift.Error {
        case buildingFailed
    }
    
    let spotifyPetitionManager: SpotifyPetitionManagerProtocol
    let restClient: RESTClient
    
    init(spotifyPetitionManager: SpotifyPetitionManager, restClient: RESTClient) {
        self.spotifyPetitionManager = spotifyPetitionManager
        self.restClient = restClient
    }
    
}

extension SpotifyPetitionManagerBuilder: SpotifyPetitionManagerBuilderProtocol {
    
    func sendRequest(for search: String?, type query: QueryType, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        let urlRequest = spotifyPetitionManager.makeRequest(for: search, query: query)
        guard let urlRequest = urlRequest else {
            onError(WebServiceError.emptyURL)
            return
        }
        restClient.performRequest(request: urlRequest) { [weak self] dataToDecode in
            guard let self = self else {
                return
            }
            onSuccess(dataToDecode)
        } onError: { [weak self] errorThrown in
            guard let self = self else {
                return
            }
            onError(errorThrown)
        }
    }
}
