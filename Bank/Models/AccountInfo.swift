//
//  AccountInfo.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation

struct AccountInfo: Codable {
    var status: String? = ""
    let accountNo: String?
    let balance: Double?
    var error: Error?
}

// MARK: - Error
struct Error: Codable {
    var name: String? = ""
    var message: String? = ""
}
