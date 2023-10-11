//
//  ProfileServise.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 21.8.23..
//

import Foundation

struct ProfileResult: Codable {
    let id: String?
    let userName: String?
    let firstName: String?
    let lastName: String?
    let bio: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(from profileResult: ProfileResult) {
        self.username = profileResult.userName ?? ""
        self.name = "\(profileResult.firstName ?? "") \(profileResult.lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
        self.loginName = "@" + self.username
        self.bio = profileResult.bio
    }
}
var profileUrl = URL(string: "https://api.unsplash.com/me")

final class ProfileService {
    static let shared = ProfileService()
    private(set) var profile: Profile?
    
    
    private var request = URLRequest(url: profileUrl!)
    private var task: URLSessionTask?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        var authToken = OAuth2TokenStorage().token
        if task != nil { return }
        
        request.httpMethod = "GET"
        
        guard let authToken = authToken else {
            return
        }
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.objectTask(for: request) {
            [weak self] (response: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let profileResult):
                self.profile = Profile(from: profileResult)
                completion(.success(self.profile!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
            }
        }
       
    

