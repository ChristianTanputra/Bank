//
//  PayeeInfo.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation

struct PayeeInfo: Codable {
    var status: String? = ""
    var payees: [Payee]
    var error: String? = ""

    enum CodingKeys: String, CodingKey {
        case status
        case payees = "data"
        case error
    }
}

struct Payee: Codable, Hashable {
    var id, name, accountNo: String
}
