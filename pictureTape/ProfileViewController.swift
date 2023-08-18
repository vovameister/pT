//
//  ProfileViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 16.7.23..
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameLabel = UILabel()
        let emailLabel = UILabel()
        let messageLabel = UILabel()
        let avatarImage = UIImageView()
        let tabDoorButton = UIButton()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        tabDoorButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Екатерина"
        emailLabel.text = "someemail@mail.com"
        messageLabel.text = "Hello"
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
        
        
        if let customNameLabelFont = UIFont(name: "SFProText-Bold", size: 23) {
            nameLabel.font = customNameLabelFont
        } else {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 23 )}
        
        if let customEmailLabelFont = UIFont(name: "SFProText-Regular", size: 13) {
            emailLabel.font = customEmailLabelFont
        } else {
            emailLabel.font = UIFont.systemFont(ofSize: 13)
        }
        
        if let customMessegeLabelFont = UIFont(name: "SFProText-Regular", size: 13) {
            messageLabel.font = customMessegeLabelFont
        } else {
            emailLabel.font = UIFont.systemFont(ofSize: 13)
        }
        
        
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
            
            
        ])}
}

