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

    @IBOutlet weak var loginButton: UIButton!
    
    
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
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
       print("button clicked")
       navigateToMainScreen()
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
        let secondView = ArtistLookUpViewController(nibName: "ArtistLookUp", bundle: nil)
        self.navigationController!.pushViewController(secondView, animated: true)
    }
    
    func alertAuthenticationFailed() {
        let alert = UIAlertController(title: Constant.alertAuthenticationFailedTitle, message: Constant.alertAuthenticationFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.alertAuthenticationFailedMessage, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

}
