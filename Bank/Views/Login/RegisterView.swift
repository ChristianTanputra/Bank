//
//  RegisterView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var networkObject: Network
    
    // Username
    let usernameTitle: String = "Username"
    let usernameSecure: Bool = false
    @State var usernameText: String = ""
    @State var usernameErrorText: String = ""
    
    // Password
    let passwordTitle: String = "Password"
    let passwordSecure: Bool = true
    @State var passwordText: String = ""
    @State var passwordErrorText: String = ""
    
    // Confirm Password
    let cfmPasswordTitle: String = "Confirm Password"
    let cfmPasswordSecure: Bool = true
    @State var cfmPasswordText: String = ""
    @State var cfmPasswordErrorText: String = ""
    
    let local = LocalNetwork()
    
    var body: some View {
        VStack {
            BoxTextfield(title: usernameTitle, isSecure: usernameSecure, text: $usernameText, errorText: $usernameErrorText)
                .padding()
            BoxTextfield(title: passwordTitle, isSecure: passwordSecure, text: $passwordText, errorText: $passwordErrorText)
                .padding([.horizontal, .bottom])
            BoxTextfield(title: cfmPasswordTitle, isSecure: cfmPasswordSecure, text: $cfmPasswordText, errorText: $cfmPasswordErrorText)
                .padding([.horizontal, .bottom])
            Spacer()
            CircularButton(text: "REGISTER", preferredButton: true) {
                if textfieldIsFilled() && isPasswordSame() {
                    Task {
                        let token = await local.register(username: usernameText, password: passwordText)
                        if token.isEmpty {
                            cfmPasswordErrorText = "Username already exists"
                        } else {
                            networkObject.setToken(token: token)
                        }
                    }
                } else {
                    setErrorTexts()
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.large)
    }
}

extension RegisterView {
    func textfieldIsFilled() -> Bool {
        if !usernameText.isEmpty && !passwordText.isEmpty && !cfmPasswordText.isEmpty {
            return true
        }
        return false
    }
    
    func isPasswordSame() -> Bool {
        if passwordText == cfmPasswordText {
            return true
        }
        return false
    }
    
    func setErrorTexts() {
        if usernameText.isEmpty {
            usernameErrorText = "Username is required"
        }
        if passwordText.isEmpty {
            passwordErrorText = "Password is required"
        }
        if cfmPasswordText.isEmpty {
            cfmPasswordErrorText = "Confirm password is required"
        }
        if !isPasswordSame() {
            cfmPasswordErrorText = "Confirm password not match"
        }
    }
}

