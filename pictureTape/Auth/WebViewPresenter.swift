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
    func code(from url: URL) -> String?
    func didUpdateProgress(_ newValue: Double)
}

final class WebViewPresenter: WebViewPresenterProtocol {
    var authHelper: AuthHelperProtocol
       
       init(authHelper: AuthHelperProtocol) {
           self.authHelper = authHelper
       }
    func code(from url: URL) -> String? {
        if let urlComponents = URLComponents(string: url.absoluteString),
           urlComponents.path == "/oauth/authorize/native",
           let items = urlComponents.queryItems,
           let codeItem = items.first(where: { $0.name == "code" })
            
        {    print("\(codeItem)")
            return codeItem.value
            
        } else {
            return nil
        }
    }
    func didUpdateProgress(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
    
    func viewDidLoad() {
        let request = authHelper.authRequest()
        view?.load(request: request)
        didUpdateProgress(0)
    }
    weak var view: WebViewViewControllerProtocol?
}

