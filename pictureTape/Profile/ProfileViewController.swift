//
//  ProfileViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 16.7.23..
//

import UIKit
import Kingfisher
import WebKit
protocol ProfileViewControllerProtocol {
    func updateAvatar()
}

class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    private let profileService = ProfileService.shared
    private let sceneDelegate = SceneDelegate()
    private let splashViewController = SplashViewController()
    
    var profilePresenter: ProfilePresenterProtocol?
    private var profileImageServiceObserver: NSObjectProtocol?
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
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
        tabDoorButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
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
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(forName: ProfileImageService.DidChangeNotification, object: nil, queue: .main) {
            [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        updateAvatar()
    }
    func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name
        emailLabel.text = profile.username
        messageLabel.text = profile.bio
    }
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        avatarImage.kf.setImage(with: url)
    }
}

