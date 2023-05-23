//
//  FakeOauthManager.swift
//  SpotifyTests
//
//  Created by Natalia Goyes on 14/06/22.
//

import Foundation
@testable import gndjf

class FakeOauthManager: OauthManagerProtocol {
    
    enum FakeError: Swift.Error {
        case dummyError
    }
    
    var authenticateWasCalled = false
    var success = true
    
    
    func authenticate(processResult: @escaping (String?, Error?) -> Void) {
        authenticateWasCalled = true
        
        if success {
            processResult("dummy", nil)
        } else {
            processResult(nil,FakeOauthManager.FakeError.dummyError)
        }
    }
    /*
    func authenticate(onSuccess: @escaping (String) -> (Void), onError: @escaping (Error) -> (Void)) {
        authenticateWasCalled = true
        
        if success {
            onSuccess("dummy")
        } else {
            onError(FakeOauthManager.FakeError.dummyError)
        }
    }*/
}
