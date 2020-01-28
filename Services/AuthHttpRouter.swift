//
//  AuthHttpRouter.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Alamofire

enum AuthHttpRouter {
    case signUp(AuthModel)
    case validateEmail(email: String)
}

extension AuthHttpRouter: HttpRouter {
    var parameters: Parameters? {
        return nil
    }
    
//    func request(usingHttpService service: HttpService) throws -> DataRequest {
//        <#code#>
//    }
    
    var baseUrlString: String {
        return "https://letscodeeasy.com/groceryapi/public/api"
    }
    
    var path: String {
        switch (self) {
        case .signUp:
            return "register"
        case .validateEmail:
            return "validate/email"
        }
    }
    
    var method: HTTPMethod {
        switch (self) {
        case .signUp, .validateEmail:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        switch (self) {
        case .signUp, .validateEmail:
            return [
                "Content-Type":"application/json; charset=UTP-8"
            ]
        }
        
    }
    
    func body() throws -> Data? {
        switch (self) {
        case .signUp(let user):
            return try JSONEncoder().encode(user)
        case .validateEmail(let email):
            return try JSONEncoder().encode(["email" : email])
        }
    }
}
