//
//  ArtistLookUpViewController.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import UIKit

protocol ArtistLookUpViewControllerProtocol: AnyObject {
    func navigateToArtistDetail()
    func alertSearchFailed()
}

class ArtistLookUpViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistName: UITextField!
    
    struct Constant {
        static let alertInitializationFailedTitle = "Initialization Failed"
        static let alertInitializationFailedMessage = "App will be detroyed"
        static let okAction = "OK"
        static let alertSearchFailedTitle = "Search Failed"
        static let alertSearchFailedMessage = "Please try again"
    }
    
    var presenter: ArtistLookUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.presenter = ArtistLookUpPresenterBuilder().build()
            self.presenter?.setViewController(self)
        } catch {
            alertInitializationFailed()
        }
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: {_ in fatalError("Initialization failed")})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        /*presenter?.processSearch(artistName: artistName.text)*/
        presenter?.processSearch(artistName: "David Bowie")
    }
}

extension ArtistLookUpViewController: ArtistLookUpViewControllerProtocol {
    
    func navigateToArtistDetail() {
        let secondView = ArtistDetailedViewController(nibName: "ArtistDetailed", bundle: nil)
        self.navigationController!.pushViewController(secondView, animated: true)
    }
  
    func alertSearchFailed() {
        let alert = UIAlertController(title: Constant.alertSearchFailedTitle, message: Constant.alertSearchFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
