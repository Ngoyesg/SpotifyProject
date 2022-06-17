//
//  LandingPresenterBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/06/22.
//

import Foundation

class LandingPresenterBuilder {
    
    enum Error: Swift.Error {
        case buildingFailed
    }
    
    func build() throws -> LandingPresenterProtocol {
        
        do {
            
            let plistReader = PlistReader()
            
            let spotifyAuthParams = try SpotifyAuthParamsBuilder(plistReader: plistReader).getParams()
            
            let spotifyScopeParams = try SpotifyScopeParamsBuilder(plistReader: plistReader).getParams()
            
            let oauth2Swift = OauthConfigurator().getAuthentifier(with: spotifyAuthParams)
            
            let oauthManager = OauthManager(oauth2Swift: oauth2Swift, spotifyScopeParams: spotifyScopeParams)
            
            let keychainSaveManager = KeychainSaveManager()
            
            let authUseCase = AuthUseCase(oauthManager: oauthManager, keychainSaveManager: keychainSaveManager)
            
            return LandingPresenter(authUseCase: authUseCase)
            
        } catch let error {
            print(error.localizedDescription)
            throw LandingPresenterBuilder.Error.buildingFailed
        }
    }
    
}
