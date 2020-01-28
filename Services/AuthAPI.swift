//
//  AuthAPI.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 1/20/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import Combine

protocol AuthAPI {
    func checkEmail(email: String) -> Future<Bool, Never>
    
    func signUp(username: String, email: String, password: String) -> Future<(statusCode: Int, data: Data), Error>
}
