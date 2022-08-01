//
//  SpotifyPetitionManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 22/07/22.
//

import Foundation

protocol SpotifyPetitionManagerProtocol: AnyObject {
    func makeRequest(for idToSearch: String?, query type: QueryType) throws -> URLRequest?
}

class SpotifyPetitionManager {
    
    let urlRequestBuilder: URLRequestBuilderProtocol
    
    init(urlRequestBuilder: URLRequestBuilder){
        self.urlRequestBuilder = urlRequestBuilder
    }
}

extension SpotifyPetitionManager: SpotifyPetitionManagerProtocol {
    
    func makeRequest(for idToSearch: String?, query type: QueryType) throws -> URLRequest {
        
        var urlRequest: 
        
        do {
            
            let urlRequest = try urlRequestBuilder.buildRequest(for: idToSearch, type: type)
            
            return urlRequest
            
        } catch let error {
            
            if let errorThrown = error as? URLRequestBuilder.Error, errorThrown == .emptyRequest {
                throw KeychainFetchManager.Error.unauthorized
            }
            if let errorThrown = error as? URLRequestBuilder.Error, errorThrown == .emptyRequest {
                throw URLRequestBuilder.Error.emptyRequest
            }
            if let errorThrown = error as? URLRequestBuilder.Error, errorThrown == .invalidURL {
                throw URLRequestBuilder.Error.invalidURL
            }
        }
    }
}
