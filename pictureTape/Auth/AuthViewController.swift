//
//  AuthViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 5.8.23..
//

import UIKit
import ProgressHUD

class AuthViewController: UIViewController {
    private let segIdentificator = "ShowWebView"
    
    private var oAuth2Service = OAuth2Service()
    
    private let tokenStorage = OAuth2TokenStorage()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segIdentificator {
            guard let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("fail \(segIdentificator)") }
            webViewViewController.delegate = self }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewControllter(_vc: WebViewViewController, didAuthernticateWithCode code: String) {
        ProgressHUD.show()
        oAuth2Service.fetchOAuthToken(code, completion: { result in
            switch result {
            case .success(let result):
                print("new token \(result)")
                ProgressHUD.dismiss()
                let tokenStorage = OAuth2TokenStorage()
                if let token = tokenStorage.token {
                    print("Token: \(token)")
                } else {
                    print("Token not found.")
                }
            case .failure(let error):
                ProgressHUD.dismiss()
                print("error \(error)")
            }})
    }
    
    func webViewViewControllerDidCancel(_vc: WebViewViewController) {
        dismiss(animated: true)
    }
    
    
}
