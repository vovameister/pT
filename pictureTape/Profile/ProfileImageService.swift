//
//  ProfileImageService.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 22.8.23..
//

import UIKit

struct UserProfile: Codable {
    let profileImage: ProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}



final class ProfileImageService {
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    static let shared = ProfileImageService()
    
    
    private var task: URLSessionTask?
    private(set) var avatarURL: String?
    
    var authToken = OAuth2TokenStorage().token
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        let profileImageURL = URL(string: "https://api.unsplash.com/users/\(username)")
        var request = URLRequest(url: profileImageURL!)
        if task != nil { return }
        request.httpMethod = "GET"
        
        guard let authToken = authToken else {
            return
        }
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.objectTask(for: request) {
            [weak self] (response: Result<UserProfile, Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let userProfile):
                self.avatarURL = userProfile.profileImage.small
                completion(.success(self.avatarURL!))
                NotificationCenter.default.post(name:ProfileImageService.DidChangeNotification,
                                                object: self,
                                                userInfo: ["URL": self.avatarURL])
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
}

