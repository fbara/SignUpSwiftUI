//
//  ContentView.swift
//  SignUpSwiftUI
//
//  Created by Frank Bara on 12/26/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = "m"
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var usernameError: String = "Required"
    var emailError: String = "Required"
    var passwordError: String = "Required"
    var confirmPasswordError: String = "Required"

    var body: some View {
        
        ZStack {
            ColorCodes.primary.color().edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Green Grocery")
                    .font(Font.custom("Noteworthy-Bold", size: 40.0))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                AuthTextField(textValue: $username, title: "Username", errorValue:usernameError)
                AuthTextField(textValue: $email, title: "Email Address", errorValue:emailError, keyboardType: .emailAddress)
                AuthTextField(textValue: $password, title: "Password", errorValue:passwordError, isSecured: true)
                AuthTextField(textValue: $confirmPassword, title: "Confirm Password", errorValue:confirmPasswordError, isSecured: true)


            }.padding(60.0)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
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
