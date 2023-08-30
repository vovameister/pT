//
//  OAuth2Service.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 8.8.23..
//

import Foundation


final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private var splashViewController = SplashViewController()
    private var task: URLSessionTask?
    private var lastCode: String?
    
    private let urlSession = URLSession.shared
    
    private (set) var authToken: String {
        get {
            return OAuth2TokenStorage().token!
        }
        set {
            OAuth2TokenStorage().token = newValue
            print("TOKEN", newValue)
        } }
    func fetchOAuthToken(
        _ code: String,
        completion: @escaping (Result<String, Error>) -> Void
    )  {
        assert(Thread.isMainThread)
        if task != nil {
            if lastCode != code {
                task?.cancel()
            } else {
                return
            }
        } else {
            if lastCode == code {
                return
           }
        }
        lastCode = code
        let request = authTokenRequest(code: code)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (respones: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            switch respones {
            case .success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                completion(.success(authToken))
                self.splashViewController.switchToTabBarController()
            case .failure(let error):
                completion(.failure(error))
                
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}
//extension OAuth2Service {
//    private func object(
//        for request: URLRequest,
//        completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void
//    ) -> URLSessionTask {
//        let decoder = JSONDecoder()
//        return urlSession.data(for: request) { (result: Result<Data, Error>) in
//            let response = result.flatMap { data -> Result<OAuthTokenResponseBody, Error> in
//                Result {
//                    try decoder.decode(OAuthTokenResponseBody.self, from: data)
//                }
//            }
//            completion(response)
//        }
//    } }
private func authTokenRequest(code: String) -> URLRequest {
    URLRequest.makeHTTPRequest(
        path: "/oauth/token"
        + "?client_id=\(accessKey)"
        + "&&client_secret=\(secretKey)"
        + "&&redirect_uri=\(redirectURI)"
        + "&&code=\(code)"
        + "&&grant_type=authorization_code",
        httpMethod: "POST",
        baseURL: URL(string: "https://unsplash.com")!
    ) }

