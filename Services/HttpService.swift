//
//  HttpService.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
