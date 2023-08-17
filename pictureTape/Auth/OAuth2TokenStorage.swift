//
//  OAuth2TokenStorage.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 8.8.23..
//

import Foundation

class OAuth2TokenStorage {
    private let tokenKey = "OAuth2AccessToken"
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}

