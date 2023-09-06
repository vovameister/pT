//
//  SplashViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 12.8.23..
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func fetchAfterAuth()
}

final class SplashViewController: UIViewController, SplashViewControllerDelegate {
    weak var delegate: SplashViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "YP Black")
        
        let logoImage = UIImageView(image: UIImage(named: "Image"))
        let imageSize = CGSize(width: 75, height: 77.68)
        
        logoImage.frame = CGRect(origin: .zero, size: imageSize)
        logoImage.center = view.center
        
        view.addSubview(logoImage)
    }
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tokenStorage = OAuth2TokenStorage()
        if tokenStorage.token == nil {
            presentAuthViewController()
        } else {
            self.fetchProfile(token: tokenStorage.token!)
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
    func fetchProfile(token: String) { profileService.fetchProfile(token) { result in
        switch result {
        case .success(_):
            if self.profileService.profile?.username != nil {
                self.profileImageService.fetchProfileImageURL(username: self.profileService.profile!.username) { _ in }
            }
            self.switchToTabBarController()
            print("success")
        case .failure(_):
            self.showAlert()
            print("error in ProfileViewController")
        }
    }
    }
    func showAlert() {
        let alert = UIAlertController(title: "Что-то пошло не так", message: "Не удалось войти в систему", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    private func presentAuthViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "AuthViewController")
        guard let authViewController = viewController as? AuthViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        authViewController.delegate = self
        present(authViewController, animated: true)
    }
    func fetchAfterAuth() {
        guard let token = OAuth2TokenStorage().token
        else { return }
        fetchProfile(token: token)
    }
}


