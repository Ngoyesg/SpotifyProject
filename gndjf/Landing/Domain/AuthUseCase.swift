//
//  AuthUseCase.swift
//  gndjf
//
//  Created by Natalia Goyes on 6/06/22.
//

import Foundation

protocol AuthUseCaseProtocol: AnyObject {
    func execute(onSuccess: @escaping ()-> (Void), onError: @escaping (AuthUseCase.Error)->(Void))
}

class AuthUseCase {
    
    let oauthManager: OauthManagerProtocol
    let keychainSaveManager: KeychainSaveManagerProtocol
    
    enum Error: Swift.Error {
        case authenticationFailed
    }
    
    init(oauthManager: OauthManagerProtocol, keychainSaveManager: KeychainSaveManagerProtocol){
        self.oauthManager = oauthManager
        self.keychainSaveManager = keychainSaveManager
    }
}

extension AuthUseCase: AuthUseCaseProtocol {
    func execute(onSuccess: @escaping ()-> (Void), onError: @escaping (AuthUseCase.Error)->(Void)) {
        oauthManager.authenticate { [weak self] token, error in
            guard let self = self else { return }
            if let token = token {
                self.keychainSaveManager.saveToken(token: token)
                onSuccess()
            }
            if error != nil {
                onError(AuthUseCase.Error.authenticationFailed)
            }
        }
    }
}
