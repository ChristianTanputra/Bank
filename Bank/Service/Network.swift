//
//  Network.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation

class Network: ObservableObject {
    
    @Published var token: String = ""
    
    init() {
        token = ""
    }

    func setToken(token: String) {
        self.token = token
    }
    
    func logout() {
        self.token = ""
    }
}
