//
//  WebViewPresenter.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 13.10.23..
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProgress(_ newValue: Double)
}

final class WebViewPresenter: WebViewPresenterProtocol {
    
    func didUpdateProgress(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
    
    fileprivate var UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    
    func viewDidLoad() {
        var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AccessScope)
        ]
        let url = urlComponents.url!
        let request = URLRequest(url: url)
        
        didUpdateProgress(0)
        
        view?.load(request: request)
    }
    weak var view: WebViewViewControllerProtocol?
}

