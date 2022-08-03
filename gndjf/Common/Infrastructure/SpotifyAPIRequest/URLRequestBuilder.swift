//
//  URLRequestBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 26/07/22.
//

import Foundation

protocol URLRequestBuilderProtocol: AnyObject {
    func setEndpoint(endpoint: BaseEndpoint)
    func build() throws -> URLRequest
}

class URLRequestBuilder {
    
    enum Error: Swift.Error {
        case unauthorized, noURL, noEndpoint
    }
    
    var endpoint: BaseEndpoint?
    let keychainManager: KeychainFetchManagerProtocol
    
    init(keychainManager: KeychainFetchManagerProtocol){
        self.endpoint = nil
        self.keychainManager = keychainManager
    }
    
    func setHTTPMethod(to urlRequest: inout URLRequest, with method: HTTPMethod) {
        urlRequest.httpMethod = method.rawValue
    }
    
    func addAuthorization(to urlRequest: inout URLRequest, with token: String) {
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    func addHTTPHeaders(to urlRequest: inout URLRequest) {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
        
}

extension URLRequestBuilder: URLRequestBuilderProtocol {
    
    func setEndpoint(endpoint: BaseEndpoint) {
        self.endpoint = endpoint
    }
    
    
    func build() throws -> URLRequest {
        
        guard let endpoint = self.endpoint else {
            throw Error.noEndpoint
        }
        
        guard let url = endpoint.getURL() else {
            throw Error.noURL
        }
        
        var urlRequest = URLRequest(url: url)
        self.setHTTPMethod(to: &urlRequest, with: endpoint.httpMethod)
        self.addHTTPHeaders(to: &urlRequest)
        
        guard let token = self.keychainManager.fetchToken() else {
            throw Error.unauthorized
        }
        self.addAuthorization(to: &urlRequest, with: token)
        
        return urlRequest
    }
}
