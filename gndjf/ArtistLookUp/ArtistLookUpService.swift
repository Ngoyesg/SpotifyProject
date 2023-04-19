//
//  ArtistLookUpService.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/07/22.
//

import Foundation

protocol ArtistLookUpServiceProtocol: AnyObject {
    func getArtistInformation(artist: String, onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void)
}

class ArtistLookUpService {
    
    enum Error: Swift.Error {
        case URLRequestError, webClientError
    }
    
    let urlRequestBuilder: URLRequestBuilderProtocol
    let restClient: WebClientProtocol
    
    init(urlRequestBuilder: URLRequestBuilderProtocol, restClient: WebClientProtocol) {
        self.urlRequestBuilder = urlRequestBuilder
        self.restClient = restClient
    }
    
    func processResponse(
        responseToDecode: Data,
        onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void,
        onError: @escaping (WebServiceError) -> Void) {
            
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
    
    func performRequest(request: URLRequest, onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        restClient.performRequest(request: request) { [weak self] dataToDecode in
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

extension ArtistLookUpService: ArtistLookUpServiceProtocol {
    
    func getArtistInformation(artist: String, onSuccess: @escaping (ArtistLookUpAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        do {
            
            let endpoint = ArtistEndpoint(search: artist)
            self.urlRequestBuilder.setEndpoint(endpoint: endpoint)
            let request = try urlRequestBuilder.build()
            performRequest(request: request, onSuccess: onSuccess, onError: onError)
            
        } catch let errorThrown {
            
            if let error = errorThrown as? URLRequestBuilder.Error, error == URLRequestBuilder.Error.unauthorized {
                onError(.unauthorizedRequest)
            }
            if let error = errorThrown as? URLRequestBuilder.Error, error == URLRequestBuilder.Error.noURL {
                onError(.noURLFound)
            }
            if let error = errorThrown as? URLRequestBuilder.Error, error == URLRequestBuilder.Error.noEndpoint {
                onError(.noEndpointFound)
            }
            if let error = errorThrown as? WebServiceError, error == WebServiceError.errorDecodingData {
                onError(.errorDecodingData)
            }
            if let error = errorThrown as? WebServiceError, error == WebServiceError.invalidRequest {
                onError(.invalidRequest)
            }
            if let error = errorThrown as? WebServiceError, error == WebServiceError.invalidStatusCodeResponse {
                onError(.invalidStatusCodeResponse)
            }
            if let error = errorThrown as? WebServiceError, error == WebServiceError.noDataToDecode {
                onError(.noDataToDecode)
            }
        }
    }
}


