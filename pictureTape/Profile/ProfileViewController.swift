//
//  ProfileViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 16.7.23..
//

import UIKit
import Kingfisher
import WebKit

class ProfileViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    private let tokenStorage = OAuth2TokenStorage()
    private let sceneDelegate = SceneDelegate()
    private let splashViewController = SplashViewController()
    
    private var profileImageServiceObserver: NSObjectProtocol?
    var window = UIApplication.shared.windows.first
    

    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let messageLabel = UILabel()
    let avatarImage = UIImageView()
    let tabDoorButton = UIButton()
    
    @objc func buttonTapped() {
        showAlertWithYesNoAction()
        print("Button tapped!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "YP Black")
        
        if let profileService = profileService.profile {
            updateProfileDetails(profile: profileService) }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        tabDoorButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let profileImage = UIImage(named: "profilePhoto")
        let tabDoorImage = UIImage(named: "door")
        avatarImage.image = profileImage
        avatarImage.layer.cornerRadius = 35
        avatarImage.clipsToBounds = true
        tabDoorButton.setImage(tabDoorImage, for: .normal)
        
        
        nameLabel.textColor = .white
        emailLabel.textColor = UIColor(named: "YP Gray")
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
       
            nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
            emailLabel.font = UIFont.systemFont(ofSize: 13)
            messageLabel.font = UIFont.systemFont(ofSize: 13)
     
        
        
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(messageLabel)
        view.addSubview(tabDoorButton)
        
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 90),
            
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 90),
            
            messageLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 90),
            
            tabDoorButton.heightAnchor.constraint(equalToConstant: 44),
            tabDoorButton.widthAnchor.constraint(equalToConstant: 44),
            tabDoorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tabDoorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 89),
            
        ])
        addGradients()
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(forName: ProfileImageService.DidChangeNotification, object: nil, queue: .main) {
            [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        let viewsWithGradients = [avatarImage, nameLabel, emailLabel, messageLabel]
        removeGradients(from: viewsWithGradients)
        updateAvatar()
    }
    func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name
        emailLabel.text = profile.username
        messageLabel.text = profile.bio
    }
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        avatarImage.kf.setImage(with: url)
        
    }
    func showAlertWithYesNoAction() {
        let alertController = UIAlertController(title: "Пока, пока!", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)

        
        let yesAction = UIAlertAction(title: "Да", style: .default) { (_) in
            self.clean()
            self.tokenStorage.removeTokenFromKeychain()
            alertController.dismiss(animated: true, completion: nil)
            self.window?.rootViewController = self.splashViewController
            self.window?.makeKeyAndVisible()
            print("User tapped 'Yes'")
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel) { (_) in
            alertController.dismiss(animated: true, completion: nil)
            print("User tapped 'No'")
        }

        alertController.addAction(yesAction)
            alertController.addAction(noAction)
           
    
        
        self.present(alertController, animated: true, completion: nil)
    }
}
extension ProfileViewController {
    func clean() {
       HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

       WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in

          records.forEach { record in
             WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
          }
       }
    }
}
extension ProfileViewController {
    func addGradients() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero, size: CGSize(width: 70, height: 70))
        gradient.locations = [0, 0.1, 0.3]
        gradient.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 1).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 35
        gradient.masksToBounds = true
        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 2.0
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        gradient.add(gradientChangeAnimation, forKey: "locationsChange")
        gradientChangeAnimation.repeatCount = .infinity
        avatarImage.layer.addSublayer(gradient)
        
        let gradientName = CAGradientLayer()
        gradientName.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 25))
        gradientName.locations = [0, 0.1, 0.3]
        gradientName.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 1).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 1).cgColor
        ]
        gradientName.startPoint = CGPoint(x: 0, y: 0.5)
        gradientName.endPoint = CGPoint(x: 1, y: 0.5)
        gradientName.masksToBounds = true
        gradientName.add(gradientChangeAnimation, forKey: "locationsChangeName")
        nameLabel.layer.addSublayer(gradientName)
      
        let gradientEmail = CAGradientLayer()
        gradientEmail.frame = CGRect(origin: .zero, size: CGSize(width: 150, height: 20))
        gradientEmail.locations = [0, 0.1, 0.3]
        gradientEmail.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 1).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 1).cgColor
        ]
        gradientEmail.startPoint = CGPoint(x: 0, y: 0.5)
        gradientEmail.endPoint = CGPoint(x: 1, y: 0.5)
        gradientEmail.masksToBounds = true
        gradientEmail.add(gradientChangeAnimation, forKey: "locationsChangeEmail")
        emailLabel.layer.addSublayer(gradientEmail)
        
        let gradientMessage = CAGradientLayer()
        gradientMessage.frame = CGRect(origin: .zero, size: CGSize(width: 250, height: 20))
        gradientMessage.locations = [0, 0.1, 0.3]
        gradientMessage.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 1).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 1).cgColor
        ]
        gradientMessage.startPoint = CGPoint(x: 0, y: 0.5)
        gradientMessage.endPoint = CGPoint(x: 1, y: 0.5)
        gradientMessage.masksToBounds = true
        gradientMessage.add(gradientChangeAnimation, forKey: "locationsChangeMessege")
        messageLabel.layer.addSublayer(gradientMessage)
    }
    func removeGradients(from views: [UIView]) {
        for view in views {
            for sublayer in view.layer.sublayers ?? [] {
                if sublayer is CAGradientLayer {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
}
