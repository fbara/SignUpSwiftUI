//
//  ContentView.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 12/26/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var viewModel: SignUpViewModel
   
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        
        ZStack {
            ColorCodes.primary.color().edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Green Grocery")
                    .font(Font.custom("Noteworthy-Bold", size: 40.0))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                AuthTextField(textValue: $viewModel.username, title: "Username", errorValue:viewModel.usernameError)
                AuthTextField(textValue: $viewModel.email, title: "Email Address", errorValue:viewModel.emailError, keyboardType: .emailAddress)
                AuthTextField(textValue: $viewModel.password, title: "Password", errorValue:viewModel.passwordError, isSecured: true)
                AuthTextField(textValue: $viewModel.confirmPassword, title: "Confirm Password", errorValue:viewModel.confirmPasswordError, isSecured: true)

                Button(action: signUp) {
                    Text("Sign Up")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(.infinity)
                .padding(.top, 20)

            }.padding(60.0)

        }
    }
    
    func signUp() -> Void {
        print("Sign up tapped!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel(authAPI: AuthService.shared, authServiceParser: AuthServiceParser.shared)
        return SignUpView(viewModel: viewModel)
    }
}

extension ColorCodes {
    
    func color() -> Color {
        switch self {
        case .primary:
            return Color(red: 79/255, green: 139/255, blue: 43/255)
        case .success:
            return Color(red: 0, green: 0, blue: 0)
        case .failure:
            return Color(red: 219/255, green: 12/255, blue: 12/255)
        case .background:
            return Color(red: 239/255, green: 243/255, blue: 244/255, opacity: 1.0)
            
        }
    }
}

struct AuthTextField: View {
    @Binding var textValue: String
    
    var title: String
    var errorValue: String
    var isSecured: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        
        VStack {
            if isSecured {
                // Show secure field for entering password
                SecureField(title, text: $textValue)
                    .padding()
                    .background(ColorCodes.background.color())
                    .cornerRadius(5)
                    .keyboardType(keyboardType)
            } else {
                
                TextField(title, text: $textValue)
                    .padding()
                    .background(ColorCodes.background.color())
                    .cornerRadius(5)
                    .keyboardType(keyboardType)
            }
                
                Text(errorValue)
                    .fontWeight(.light)
                    .foregroundColor(ColorCodes.failure.color())
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}
