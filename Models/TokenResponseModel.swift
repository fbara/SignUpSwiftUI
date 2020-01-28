//
//  TokenResponseModel.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/27/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

struct TokenResponseModel: Decodable {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
