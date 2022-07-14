//
//  ArtistLookUpPresenterBuilder.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import Foundation

class ArtistLookUpPresenterBuilder {
    
    enum Error: Swift.Error {
        case buildingFailed
    }
    
    func build() throws -> ArtistLookUpPresenter {
        
        do {
            
            let searchUseCase = SearchUseCase()
            return ArtistLookUpPresenter(searchUseCase: searchUseCase)
            
        } catch let error {
            
            print(error.localizedDescription)
            throw ArtistLookUpPresenterBuilder.Error.buildingFailed
        }
    }
}
