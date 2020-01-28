//
//  AuthHttpService.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Alamofire

final class AuthHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
