//
//  PrifileViewHelper.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 18.10.23..
//

import Foundation
protocol ProfileViewHealperProtocol {
    func updateAvatar()
    func updateProfile(profile: Profile)
}
class ProfileViewHelper: ProfileViewHealperProtocol {
    private let profileViewController: ProfileViewController?

    init(viewController: ProfileViewController) {
        self.profileViewController = viewController
    }

    func updateProfile(profile: Profile) {
        profileViewController?.nameLabel.text = profile.name
        profileViewController?.emailLabel.text = profile.username
        profileViewController?.messageLabel.text = profile.bio
    }

    func updateAvatar() {
        guard let profileImageURL = ProfileImageService.shared.avatarURL,
              let url = URL(string: profileImageURL) else { return }
        profileViewController?.avatarImage.kf.setImage(with: url)
    }
}
