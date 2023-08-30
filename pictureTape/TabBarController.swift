//
//  TabBarController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 28.8.23..
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storybord = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewController = storybord.instantiateViewController(withIdentifier: "ImagesListViewController")
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_profile_active"), selectedImage: nil)
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}

