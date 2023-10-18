//
//  Constaints.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 27.7.23..
//

import Foundation

let AccessKey = "yPBGa0VCfMg88nr_9REiR0-W92m8bZsRmHByHcsCoVc"
let SecretKey = "jlDjZeMIwKIra3ShgEG3Y1rQi_vbw74IhUq2lFMVtMM"

let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let DefaultBaseURL = URL(string: "https://api.unsplash.com/")
let AccessScope = "public+read_user+write_likes"
let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    static var standard: AuthConfiguration {
          return AuthConfiguration(accessKey: AccessKey,
                                   secretKey: SecretKey,
                                   redirectURI: RedirectURI,
                                   accessScope: AccessScope,
                                   authURLString: UnsplashAuthorizeURLString,
                                   defaultBaseURL: DefaultBaseURL!)
      }
}
