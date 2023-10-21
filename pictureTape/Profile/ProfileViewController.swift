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
    private let sceneDelegate = SceneDelegate()
    private let splashViewController = SplashViewController()
    
    var profilePresenter: ProfilePresenterProtocol?
    var profileViewHelper: ProfileViewHealperProtocol?
    private var profileImageServiceObserver: NSObjectProtocol?
    
    let nameLabel = UILabel()
    let nNLabel = UILabel()
    let messageLabel = UILabel()
    let avatarImage = UIImageView()
    let tabDoorButton = UIButton()
    

    @objc func buttonTapped() {
        profilePresenter?.showAlertWithYesNoAction()
        print("Button tapped!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePresenter = ProfilePresenter(viewController: self)
        profileViewHelper = ProfileViewHelper(viewController: self)
        
        view.backgroundColor = UIColor(named: "YP Black")
        
        if let profileService = profileService.profile {
            profileViewHelper?.updateProfile(profile: profileService)
        }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nNLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        tabDoorButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let profileImage = UIImage(named: "profilePhoto")
        let tabDoorImage = UIImage(named: "door")
        avatarImage.image = profileImage
        avatarImage.layer.cornerRadius = 35
        avatarImage.clipsToBounds = true
        tabDoorButton.setImage(tabDoorImage, for: .normal)
        tabDoorButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        tabDoorButton.accessibilityIdentifier = "logout button"
        
        nameLabel.textColor = .white
        nNLabel.textColor = UIColor(named: "YP Gray")
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
       
            nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nNLabel.font = UIFont.systemFont(ofSize: 13)
            messageLabel.font = UIFont.systemFont(ofSize: 13)
     
        
        
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(nNLabel)
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
            
            nNLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nNLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nNLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 90),
            
            messageLabel.leadingAnchor.constraint(equalTo: nNLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nNLabel.bottomAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 90),
            
            tabDoorButton.heightAnchor.constraint(equalToConstant: 44),
            tabDoorButton.widthAnchor.constraint(equalToConstant: 44),
            tabDoorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tabDoorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 89),
            
        ])
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(forName: ProfileImageService.DidChangeNotification, object: nil, queue: .main) {
            [weak self] _ in
            guard let self = self else { return }
            profileViewHelper?.updateAvatar()
        }
        profileViewHelper?.updateAvatar()
    }
}

