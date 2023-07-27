//
//  ProfileViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 16.7.23..
//

import UIKit

class ProfileViewController: UIViewController {
    
//    @IBOutlet weak var photoImage: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var mailLabel: UILabel!
//    @IBOutlet weak var messegeLabel: UILabel!
//    
//    @IBOutlet var doorButton: UIButton!
//    @IBAction func tapDoorButton(_ sender: Any) {
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameLabel = UILabel()
        let emailLabel = UILabel()
        let messegeLabel = UILabel()
        let avatarImage = UIImageView()
        let tabDoorButton = UIButton()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        messegeLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        tabDoorButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Екатерина"
        emailLabel.text = "someemail@mail.com"
        messegeLabel.text = "Hello"
        let profileImage = UIImage(named: "profilePhoto")
        let tabDoorImage = UIImage(named: "door")
        avatarImage.image = profileImage
        tabDoorButton.setImage(tabDoorImage, for: .normal)
        
        
        nameLabel.textColor = .white
        emailLabel.textColor = UIColor(named: "YP Gray")
        messegeLabel.textColor = .white
        
        //перепробовал все танци с бубнами чтобы заработали шрифты из файлов sf pro, НИПАНИМАЮ, напишите пожалуйста в комментария к пулу, что не так
        if let customNameLabelFont = UIFont(name: "SF-Pro-Text-Bold", size: 23) {             nameLabel.font = customNameLabelFont
             } else
        { print("wrong font")
                 nameLabel.font = UIFont.boldSystemFont(ofSize: 23 )}
        
        if let customEmailLabelFont = UIFont(name: "SF-Pro-Text-Regular", size: 13) {
            emailLabel.font = customEmailLabelFont
        } else {
            emailLabel.font = UIFont.systemFont(ofSize: 13)
        }
        
        if let customMessegeLabelFont = UIFont(name: "SF-Pro-Text-Regular", size: 13) {
            messegeLabel.font = customMessegeLabelFont
        } else {
            emailLabel.font = UIFont.systemFont(ofSize: 13)
        }
               
        
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(messegeLabel)
        view.addSubview(tabDoorButton)
    
        NSLayoutConstraint.activate([
        avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
        avatarImage.heightAnchor.constraint(equalToConstant: 70),
        avatarImage.widthAnchor.constraint(equalToConstant: 70),
        
        nameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
        
        emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
        
        messegeLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
        messegeLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
        
        tabDoorButton.heightAnchor.constraint(equalToConstant: 44),
        tabDoorButton.widthAnchor.constraint(equalToConstant: 44),
        tabDoorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        tabDoorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 89),
        
                
    ])}
}

