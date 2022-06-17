//
//  LandingViewControllerViewController.swift
//  gndjf
//
//  Created by Natalia Goyes on 31/05/22.
//

import UIKit

protocol LandingViewControllerProtocol: AnyObject {
    func navigateToMainScreen()
    func alertAuthenticationFailed()
}

class LandingViewController: UIViewController {
    
    struct Constant {
        static let alertAuthenticationFailedTitle = "Authentication Failed"
        static let alertAuthenticationFailedMessage = "Please try again"
        static let alertInitializationFailedTitle = "Initialization Failed"
        static let alertInitializationFailedMessage = "App will be detroyed"
    }
    
    var presenter: LandingPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            self.presenter = try LandingPresenterBuilder().build()
            self.presenter?.setViewController(self)
        } catch {
            alertInitializationFailed()
        }
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertAuthenticationFailedTitle, message: Constant.alertAuthenticationFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.alertAuthenticationFailedMessage, style: .default, handler: {_ in fatalError("Initialization failed")})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    
}

extension LandingViewController: LandingViewControllerProtocol {    
    func navigateToMainScreen() {
        print("we are moviiiiiiiiiing")
    }
    
    func alertAuthenticationFailed() {
        let alert = UIAlertController(title: Constant.alertAuthenticationFailedTitle, message: Constant.alertAuthenticationFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.alertAuthenticationFailedMessage, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
