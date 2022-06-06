//
//  TransferInfo.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation

struct LocalTransferInfo: Codable {
    let receipientAccountNo: String
    let amount: Double
    let description: String
}

struct TransferInfo: Codable {
    let status: String
    let transactionId: String?
    let amount: Double?
    let description: String?
    let recipientAccount: String?
    var error: String? = ""
}
