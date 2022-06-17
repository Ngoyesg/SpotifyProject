//
//  FakeAuthUseCase.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 15/06/22.
//

import Foundation
@testable import gndjf

class FakeAuthUseCase: AuthUseCaseProtocol {
    
    var success = true
    var executeWasCalled = false
    
    func execute(onSuccess: @escaping () -> (Void), onError: @escaping (AuthUseCase.Error) -> (Void)) {
        self.executeWasCalled = true
        
        if success {
            onSuccess()
        } else {
            onError(AuthUseCase.Error.authenticationFailed)
        }
    }
}
