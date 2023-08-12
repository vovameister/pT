//
//  WebViewViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 5.8.23..
//

import UIKit
import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewControllter(_vc: WebViewViewController, didAuthernticateWithCode code: String)
    func webViewViewControllerDidCancel(_vc: WebViewViewController)
}

fileprivate var UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

final class WebViewViewController: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    
    @IBOutlet var progressView: UIProgressView!
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        delegate?.webViewViewControllerDidCancel(_vc: self)
    }
    
        
    weak var delegate: WebViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)
        urlComponents?.queryItems = [
        URLQueryItem(name: "client_id", value: accessKey),
        URLQueryItem(name: "redirect_uri", value: redirectURI),
        URLQueryItem(name: "response_type", value: "code"),
        URLQueryItem(name: "scope", value: AccessScope)
        ]
        if let url = urlComponents?.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        updateProgress()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil) }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
}
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewControllter(_vc: self, didAuthernticateWithCode: code)
            decisionHandler(.cancel)
        } else {
                decisionHandler(.allow)
            }
    }
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if let url = navigationAction.request.url,
           let urlComponents = URLComponents(string: url.absoluteString),
           urlComponents.path == "/oauth/authorize/native",
           let items = urlComponents.queryItems,
           let codeItem = items.first(where: { $0.name == "code" })
            
        {    print("\(codeItem)")
            return codeItem.value
           
        } else {
            return nil } } }
//extension WebViewViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        performSegue(withIdentifier: "segueAfterAuth", sender: self)
//    }
//}
