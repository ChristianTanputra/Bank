//
//  User.swift
//  Bank
//
//  Created by Christian Tanputra on 2/6/2022.
//

import Foundation

struct LocalUser: Codable {
    let username: String
    let password: String
}

struct User: Codable {
    let status: String
    let token: String?
    let username: String?
    let accountNo: String?
    let error: String?
}
