//
//  Constaints.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 27.7.23..
//

import Foundation
enum Constants {
    static let accessKey = "yPBGa0VCfMg88nr_9REiR0-W92m8bZsRmHByHcsCoVc"
    static let secretKey = "jlDjZeMIwKIra3ShgEG3Y1rQi_vbw74IhUq2lFMVtMM"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com/")
    static let accessScope = "public+read_user+write_likes"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
}
struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String,
         secretKey: String,
         redirectURI: String,
         accessScope: String,
         authURLString: String,
         defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURI: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 authURLString: Constants.unsplashAuthorizeURLString,
                                 defaultBaseURL: Constants.defaultBaseURL!)
      }
}
