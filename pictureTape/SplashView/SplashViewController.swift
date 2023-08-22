//
//  SplashViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 12.8.23..
//

import UIKit

final class SplashViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tokenStorage = OAuth2TokenStorage()
        if tokenStorage.token == nil {
            performSegue(withIdentifier: "segueInAuth", sender: self)
        } else {
            switchToTabBarController()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

