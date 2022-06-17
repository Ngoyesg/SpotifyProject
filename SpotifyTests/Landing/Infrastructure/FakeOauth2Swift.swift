//
//  FakeOauth2Swift.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/06/22.
//

import Foundation
import OAuthSwift

class FakeOauth2Swift: OAuth2Swift {
    
    var success = true
    var authorizeWasCalled = false
    
    override func authorize(withCallbackURL callbackURL: URLConvertible?, scope: String, state: String, parameters: OAuth2Swift.Parameters = [:], headers: OAuthSwift.Headers? = nil, completionHandler completion: @escaping OAuth2Swift.TokenCompletionHandler) -> OAuthSwiftRequestHandle? {
       
        authorizeWasCalled = true
        
        if success {
            let credentialForToken: OAuthSwiftCredential = OAuthSwiftCredential(consumerKey: "dummy", consumerSecret: "dummy")
            let responseForToken: OAuthSwiftResponse? = nil
            let parametersForToken: Parameters = [:]
            let tokenSuccess: (credential: OAuthSwiftCredential, response: OAuthSwiftResponse?, parameters: Parameters) = (credentialForToken, responseForToken, parametersForToken)
            completion(.success(tokenSuccess))
        } else {
            completion(.failure(OAuthSwiftError.missingToken))
        }
        return nil
    }
    
}
