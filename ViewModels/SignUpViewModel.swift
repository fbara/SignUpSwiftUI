//
//  SignUpViewModel.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 12/27/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    var usernameError: String = "Required"
    var emailError: String = "Required"
    var passwordError: String = "Required"
    var confirmPasswordError: String = "Required"
}
