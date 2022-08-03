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
    
    func setEndpoint(endpoint: BaseEndpoint) {
        self.endpoint = endpoint
    }
    
    func build() throws -> URLRequest {
        return URLRequest(url: URL(string: "fooString")!)
    }
    
}
