//
//  FakeURLRequestBuilder.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 2/08/22.
//

import Foundation
@testable import gndjf

class FakeURLRequestBuilder: URLRequestBuilderProtocol {
    
    var endpoint: BaseEndpoint?
    
    var noEndpointCase = false
    var noURLCase = false
    var unauthorizedCase = false
    
    func setEndpoint(endpoint: BaseEndpoint) {
        self.endpoint = endpoint
    }
    
    func build() throws -> URLRequest {
        
        if noEndpointCase {
            throw URLRequestBuilder.Error.noEndpoint
        } else if noURLCase {
            throw URLRequestBuilder.Error.noURL
        } else if unauthorizedCase {
            throw URLRequestBuilder.Error.unauthorized
        } else {
            return URLRequest(url: URL(string: "fooString")!)
        }
        
    }
    
}
