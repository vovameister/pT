//
//  WebVIewPresenterSpy.swift
//  pTTests
//
//  Created by Владимир Клевцов on 17.10.23..
//
@testable import pictureTape
import Foundation

final class WebVIewPresenterSpy: WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    
    func viewDidLoad() {
            viewDidLoadCalled = true
        }
        
        func didUpdateProgress(_ newValue: Double) {
        
        }
        
        func code(from url: URL) -> String? {
            return nil
        }
}
final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: pictureTape.WebViewPresenterProtocol?

    var loadRequestCalled: Bool = false

    func load(request: URLRequest) {
        loadRequestCalled = true
    }

    func setProgressValue(_ newValue: Float) {

    }

    func setProgressHidden(_ isHidden: Bool) {

    }
}
