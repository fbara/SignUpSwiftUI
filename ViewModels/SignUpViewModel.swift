//
//  SignUpViewModel.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 12/27/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    private var cancellableBag = Set<AnyCancellable>()
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    var usernameError: String = ""
    var emailError: String = ""
    var passwordError: String = ""
    var confirmPasswordError: String = ""
    
    private var usernameValidPublisher: AnyPublisher<Bool, Never> {
        
        return $username
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var emailRequiredPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
        
        return $email
            .map { (email: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var emailValidPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
        
        return emailRequiredPublisher
            .filter { $0.isValid }
            .map { (email: $0.email, isValid: $0.email.isValidEmail()) }
            .eraseToAnyPublisher()
    }

    
    init() {
        
        usernameValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "" : "Username is missing" }
            .assign(to: \.usernameError, on: self)
            .store(in: &cancellableBag)
        
        emailRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "" : "Email is missing." }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellableBag)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "" : "Email is not valid." }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellableBag)
        
    }
    
    deinit {
        cancellableBag.removeAll()
    }
}

extension String {
    // Evaluates what the user entered to ensure it's a valid email address
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: self)
    }
}
