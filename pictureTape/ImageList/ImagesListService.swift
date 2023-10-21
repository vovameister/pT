//
//  ImagesListService.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 19.9.23..
//

import Foundation

final class ImagesListService {
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    var photo: [Photo] = []
    
    private var lastLoadedPage: Int = 1
    private var task: URLSessionTask?
    
    private var urlComponents = URLComponents(string: "https://api.unsplash.com/photos")
    
    private var authToken = OAuth2TokenStorage().token
    
    
    
    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let pageQueryItem = URLQueryItem(name: "page", value: "\(lastLoadedPage)")
        urlComponents?.queryItems = [pageQueryItem]
        if let finalUrl = urlComponents?.url {
            print("\(finalUrl)")
            var request = URLRequest(url: finalUrl)
            request.httpMethod = "GET"
            guard let authToken = authToken else {
                return
            }
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
            if task != nil { return }
            
            let task = URLSession.shared.objectTask(for: request) {
                [weak self] (response: Result<[PhotoResult], Error>) in
                guard let self = self else { return }
                switch response {
                case .success(let photoResults):
                    self.lastLoadedPage += 1
                    DispatchQueue.main.async {
                        for photoResult in photoResults {
                            self.photo.append(Photo(from: photoResult))
                        }
                        completion(.success(self.photo))
                        NotificationCenter.default.post(name: ImagesListService.DidChangeNotification,
                                                        object: self,
                                                        userInfo: ["URL": self.photo])
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string:"https://api.unsplash.com/photos/\(photoId)/like")
        var request = URLRequest(url: url!)
        if isLike == false {
            request.httpMethod = "POST"
        }
        else {
            request.httpMethod = "DELETE"
        }
        guard let authToken = authToken else {
            return
        }
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        print(request)
        print(request.httpMethod)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print("\(String(describing: response))")
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                completion(.success(()))
                if let index = self.photo.firstIndex(where: { $0.id == photoId }) {
                    var photo = self.photo[index]
                    photo.isLike()
                    print(photo.isLiked)
                    self.photo[index] = photo
                }
            }
            else if let error = error {
                print("\(error)")
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
}
