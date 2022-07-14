//
//  ArtistLookUpPresenter.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import Foundation

protocol ArtistLookUpPresenterProtocol: AnyObject {
    func setViewController(_ viewController: ArtistLookUpViewControllerProtocol)
    func processSearch(artistName: String?)
}

class ArtistLookUpPresenter {
    
    enum Error: Swift.Error {
        case loginFailed
    }
    
    weak var viewController: ArtistLookUpViewControllerProtocol?
    var searchUseCase: SearchUseCaseProtocol

    init(searchUseCase: SearchUseCaseProtocol){
        self.searchUseCase = searchUseCase
    }
}

extension ArtistLookUpPresenter: ArtistLookUpPresenterProtocol {
    
    func setViewController(_ viewController: ArtistLookUpViewControllerProtocol){
        self.viewController = viewController
    }
    
    func processSearch(artistName: String?) {
        self.searchUseCase.execute(parameter: artistName) { [weak self] in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.navigateToArtistDetail()
        } onError: { [weak self] error in
            guard let self = self, let controller = self.viewController else {
                return
            }
            print(error)
            controller.alertSearchFailed()
        }
    }
}
