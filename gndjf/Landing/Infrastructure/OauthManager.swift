//
//  OauthManager.swift
//  gndjf
//
//  Created by Natalia Goyes on 6/06/22.
//

import Foundation
import OAuthSwift

protocol OauthManagerProtocol: AnyObject {
    func authenticate(processResult: @escaping (String?, Error?) -> Void)
    #warning("delete this commented method when finished refactoring")
    //func authenticate(onSuccess: @escaping (String)->(Void), onError: @escaping (Error)-> (Void))
}

class OauthManager {
    var oauthswift: OAuth2Swift
    var scopeParams: SpotifyScopeParams
    
    init(oauth2Swift: OAuth2Swift, spotifyScopeParams: SpotifyScopeParams){
        self.oauthswift = oauth2Swift
        self.scopeParams = spotifyScopeParams
    }
}

extension OauthManager: OauthManagerProtocol {
    func authenticate(processResult: @escaping (String?, Error?) -> Void) {
        self.oauthswift.authorize(
            withCallbackURL: URL(string: self.scopeParams.withCallbackURL)!,
            scope: self.scopeParams.scope,
            state: generateState(withLength: self.scopeParams.state)
        ) { result in
                switch result {
                case .success(let (credential, _, _)):
                    processResult(credential.oauthToken, nil)
                case .failure(let error):
                    processResult(nil, error)
                }
        }
    }
}
