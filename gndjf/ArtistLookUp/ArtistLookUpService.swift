//
//  ArtistLookUpService.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/07/22.
//

import Foundation


protocol ArtistLookUpServiceProtocol: AnyObject {
    func getArtistInformation(artist: String?, onSuccess: @escaping (ArtistLookUpAPIResponse) -> (Void), onError: @escaping (WebServiceError)-> (Void))
}

class ArtistLookUpService {
    
    let keychainFetchManager: KeychainFetchManagerProtocol
    let urlRequestBuilder: URLRequestBuilderProtocol
    let restClient: RESTClient
    
    init(keychainFetchManager: KeychainFetchManagerProtocol, urlRequestBuilder: URLRequestBuilder, restClient: RESTClient) {
        self.keychainFetchManager = keychainFetchManager
        self.urlRequestBuilder = urlRequestBuilder
        self.restClient = restClient
    }
    
    private func getURLRequest(from artist: String?) -> URLRequest? {
        do {
            let token = keychainFetchManager.fetchToken()
            let request = try urlRequestBuilder.buildRequest(for: artist, type: .artist, authorization: token)
            return request
        } catch {
            return nil
        }
    }
    
    func processResponse(
        responseToDecode: Data,
        onSuccess: @escaping (ArtistLookUpAPIResponse) -> (Void),
        onError: @escaping (WebServiceError)-> (Void)) {
            
            let decoder = JSONDecoder()
            
            do {
                let decodifiedResponse = try decoder.decode(ArtistLookUpAPIResponse.self, from: responseToDecode)
                onSuccess(decodifiedResponse)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                onError(.errorDecodingData)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch {
                print("error: ", error)
                onError(.errorDecodingData)
            }
        }
}

extension ArtistLookUpService: ArtistLookUpServiceProtocol {
    
    func getArtistInformation(artist: String?, onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        guard let artistRequest = self.getURLRequest(from: artist) else {
            onError(WebServiceError.invalidRequest)
            return
        }

        restClient.performRequest(request: artistRequest) { [weak self] dataToDecode in
            guard let self = self else {
                return
            }
            self.processResponse(responseToDecode: dataToDecode, onSuccess: onSuccess, onError: onError)
        } onError: {  [weak self] errorThrown in
            guard let self = self else {
                return
            }
            onError(errorThrown)
        }
    }
}


