//
//  FakeSearchUseCase.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 8/07/22.
//

import Foundation
@testable import gndjf

class FakeSearchUseCase: SearchUseCaseProtocol {
    
    func execute(parameter: String?, onSuccess: @escaping () -> (Void), onError: @escaping (SearchUseCase.Error) -> (Void))  {
        if parameter == nil {
            onError(SearchUseCase.Error.invalidEmptySearch)
        } else {
            onSuccess()
        }
    }
    
}
