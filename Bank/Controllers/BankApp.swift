//
//  BankApp.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import SwiftUI

@main
struct BankApp: App {
    
    @StateObject var networkObject = Network()
    
    @State var showLogin: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                DashboardView()
                    .environmentObject(networkObject)
                    .fullScreenCover(isPresented: $showLogin) {
                        LoginView()
                            .environmentObject(networkObject)
                    }
            }
            .onChange(of: networkObject.token) { tokenString in
                showLogin = tokenString.isEmpty
            }
        }
    }
}
