//
//  ImagesListService.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 19.9.23..
//

import Foundation
struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    init(from photoResult: PhotoResult) {
        id = photoResult.id
        size = CGSize(width: photoResult.width, height: photoResult.height)
        createdAt = photoResult.createdAt
        welcomeDescription = photoResult.descriptionM
        thumbImageURL = photoResult.urlsPhoto.thumb
        largeImageURL = photoResult.urlsPhoto.full
        isLiked = photoResult.likedByUser
    } }
struct PhotoResult: Codable {
    let id: String
    let width: Int
    let height: Int
    let createdAt: Date?
    let descriptionM: String?
    let urlsPhoto: URLs
    let likedByUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case width = "width"
        case height = "height"
        case createdAt = "created_at"
        case descriptionM = "description"
        case urlsPhoto = "urls"
        case likedByUser = "liked_by_user"
    }
}
struct URLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
//var imagesListUrl = URL(string: "https://api.unsplash.com/photos")

final class ImagesListService {
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    private (set) var photo: [Photo] = []
    
    private var lastLoadedPage: Int = 0
    private var task: URLSessionTask?
    
    private var urlComponents = URLComponents(string: "https://api.unsplash.com/photos")
    
    
    
    
    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
        var pageQueryItem = URLQueryItem(name: "page", value: "\(lastLoadedPage)")
        urlComponents?.queryItems = [pageQueryItem]
        if let finalUrl = urlComponents?.url {
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            
            if task != nil { return }
            
            let task = URLSession.shared.objectTask(for: request) {
                [weak self] (response: Result<PhotoResult, Error>) in
                guard let self = self else { return }
                switch response {
                case .success(let photoResult):
                    DispatchQueue.main.async {
                        self.photo.append(Photo(from: photoResult))
                    }
                    completion(.success(self.photo))
                    NotificationCenter.default.post(name:ProfileImageService.DidChangeNotification,
                                                    object: self,
                                                    userInfo: ["URL": self.photo])
                    lastLoadedPage += 1
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
