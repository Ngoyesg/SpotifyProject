//
//  SearchUseCase.swift
//  gndjf
//
//  Created by Natalia Goyes on 30/06/22.
//

import Foundation

protocol SearchUseCaseProtocol: AnyObject {
    func execute(parameter: String?, onSuccess: @escaping ()-> (Void), onError: @escaping (SearchUseCase.Error)->(Void))
}

class SearchUseCase {
    
    enum Error: Swift.Error {
        case invalidEmptySearch, searchFailed
    }
}

extension SearchUseCase: SearchUseCaseProtocol {
    func execute(parameter: String?, onSuccess: @escaping ()-> (Void), onError: @escaping (SearchUseCase.Error)->(Void)) {
        guard parameter != nil else {
            onError(SearchUseCase.Error.invalidEmptySearch)
            return
        }
        do {
            // let succeded = try
            onSuccess()
        } catch {
            onError(SearchUseCase.Error.searchFailed)
        }
    }

}
