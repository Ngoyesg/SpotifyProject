//
//  LandingPresenter.swift
//  gndjf
//
//  Created by Natalia Goyes on 15/06/22.
//

import Foundation

protocol LandingPresenterProtocol: AnyObject {
    func processLoginClicked()
    func setViewController(_ viewController: LandingViewControllerProtocol)
}


class LandingPresenter {
    
    enum Error: Swift.Error {
        case loginFailed
    }
   
    weak var viewController: LandingViewControllerProtocol?
    var authUseCase: AuthUseCaseProtocol
    
    init(authUseCase: AuthUseCaseProtocol){
        self.authUseCase = authUseCase
    }
}

extension LandingPresenter: LandingPresenterProtocol {
    
    func setViewController(_ viewController: LandingViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func processLoginClicked() {
        self.authUseCase.execute { [weak self] in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.navigateToMainScreen()
        } onError: { [weak self] error in
            guard let self = self, let controller = self.viewController else{
                return
            }
            controller.alertAuthenticationFailed()
        }
    }
}
