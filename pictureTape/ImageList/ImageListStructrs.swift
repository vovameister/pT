//
//  ImageListStructrs.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 1.10.23..
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    var createdAt: String?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    var isLiked: Bool
    
    init(from photoResult: PhotoResult) {
        id = photoResult.id
        size = CGSize(width: photoResult.width, height: photoResult.height)
        createdAt = photoResult.createdAt ?? ""
        welcomeDescription = photoResult.descriptionM
        thumbImageURL = photoResult.urlsPhoto.thumb
        largeImageURL = photoResult.urlsPhoto.full
        isLiked = photoResult.likedByUser
    }
    init(copyFrom photo: Photo) {
           id = photo.id
           size = photo.size
           createdAt = photo.createdAt
           welcomeDescription = photo.welcomeDescription
           thumbImageURL = photo.thumbImageURL
           largeImageURL = photo.largeImageURL
           isLiked = photo.isLiked
       }
    mutating func isLike() {
           isLiked = !isLiked
       }
    func convertCreatedAtToDate() -> Date? {
        guard let createdAt = createdAt else {
            return nil
        }
        return DateFormatter.dateFormatter.date(from: createdAt)
    }
}

struct PhotoResult: Codable {
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let likedByUser: Bool
    let descriptionM: String?
    let urlsPhoto: URLs
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case width = "width"
        case height = "height"
        case likedByUser = "liked_by_user"
        case descriptionM = "description"
        case urlsPhoto = "urls"
    }
}
struct URLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
extension DateFormatter {
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
}
