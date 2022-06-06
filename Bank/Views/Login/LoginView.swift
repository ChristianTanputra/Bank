//
//  LoginView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
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
    
    let local = LocalNetwork()
    
    var body: some View {
        NavigationView {
            VStack {
                BoxTextfield(title: usernameTitle, isSecure: usernameSecure, text: $usernameText, errorText: $usernameErrorText)
                    .padding()
                BoxTextfield(title: passwordTitle, isSecure: passwordSecure, text: $passwordText, errorText: $passwordErrorText)
                    .padding([.horizontal, .bottom])
                Spacer()
                CircularButton(text: "LOGIN", preferredButton: true) {
                    if textfieldIsFilled() {
                        Task {
                            let token = await local.login(username: usernameText, password: passwordText)
                            if token.isEmpty {
                                passwordErrorText = "Username or password is wrong"
                            } else {
                                networkObject.setToken(token: token)
                            }
                        }
                    } else {
                        setErrorTexts()
                    }
                }
                NavigationLink(destination: RegisterView().environmentObject(networkObject)) {
                    CircularButtonBase(text: "REGISTER", preferredButton: false)
                }
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

extension LoginView {
    func textfieldIsFilled() -> Bool {
        if !usernameText.isEmpty && !passwordText.isEmpty {
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
    }
}
