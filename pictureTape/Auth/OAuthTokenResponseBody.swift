//
//  OAuthTokenResponseBody.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 7.8.23..
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let typeToken: String
    let scope: String
    let createdAt: Int
        enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case typeToken = "token_type"
        case scope = "scope"
        case createdAt = "created_at"
    }
}
