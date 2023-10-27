//
//  OAuth2TokenStorage.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 8.8.23..
//

import Foundation
import SwiftKeychainWrapper
 
final class OAuth2TokenStorage {
    private let tokenKey = "OAuth2AccessToken"
    
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: tokenKey)
        }
        set {
            if let newToken = newValue {
                KeychainWrapper.standard.set(newToken, forKey: tokenKey)
            } else {
                removeTokenFromKeychain()
            }
        }
    }
    func removeTokenFromKeychain() {
        KeychainWrapper.standard.removeObject(forKey: tokenKey)
    }
}
