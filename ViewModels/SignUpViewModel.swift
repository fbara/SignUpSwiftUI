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
    
    private var passwordRequiredPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
        
        return $password
            .map { (password: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var passwordValidPublisher: AnyPublisher<Bool, Never> {
        
        return passwordRequiredPublisher
            .filter { $0.isValid }
            .map { $0.password.isValidPassword() }
            .eraseToAnyPublisher()
    }
    
    private var confirmPasswordRequiredPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
        
        return $confirmPassword
            .map { (password: $0, isValid: !$0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    private var passwordEqualPublisher: AnyPublisher<Bool, Never> {
        
        return Publishers.CombineLatest($password, $confirmPassword)
            .filter { !$0.0.isEmpty && !$0.1.isEmpty }
            .map { password, confirm in
                return password == confirm
            }
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
        
        passwordRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "" : "Password is missing."}
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellableBag)
        
        passwordValidPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? "" : "Password must be 8 characters with 1 alpa and 1 number" }
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellableBag)
        
        confirmPasswordRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "" : "Confirm password is missing."}
            .assign(to: \.confirmPasswordError, on: self)
            .store(in: &cancellableBag)
        
        passwordEqualPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "" : "Password does not match."}
            .assign(to: \.confirmPasswordError, on: self)
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
    
    func isValidPassword(pattern: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") -> Bool {
        let passwordRegex = pattern
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
