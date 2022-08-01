//
//  ArtistDetailedViewController.swift
//  gndjf
//
//  Created by Natalia Goyes on 17/06/22.
//

import UIKit

protocol ArtistDetailedViewControllerProtocol: AnyObject {
    func navigateToAlbumDetail()
    func alertSearchFailed()
}

class ArtistDetailedViewController: UIViewController {
    
    
    struct Constant {
        static let alertInitializationFailedTitle = "Initialization Failed"
        static let alertInitializationFailedMessage = "App will be detroyed"
        static let okAction = "OK"
        static let alertSearchFailedTitle = "Search Failed"
        static let alertSearchFailedMessage = "Please try again"
    }
    
    var presenter: ArtistDetailedPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
           // self.presenter = try ArtistDetailedPresenterBuilder().build()
            self.presenter?.setViewController(self)
        } catch {
            self.alertInitializationFailed()
        }
    }
    
    func alertInitializationFailed(){
        let alert = UIAlertController(title: Constant.alertInitializationFailedTitle, message: Constant.alertInitializationFailedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.okAction, style: .default, handler: {_ in fatalError("Initialization failed")})
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension ArtistDetailedViewController: ArtistDetailedViewControllerProtocol {
    
    func navigateToAlbumDetail() {
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
/*
extension ArtistDetailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}*/
