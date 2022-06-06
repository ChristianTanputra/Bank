//
//  TransactionHistory.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation

struct TransactionHistory: Codable {
    let status: String? = ""
    var transactions: [Transaction]
    let error: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case status
        case transactions = "data"
        case error
    }
}

struct Transaction: Codable {
    let transactionID: String
    let amount: Double
    let transactionDate, transDescription, transactionType: String
    let receipient, sender: Receipient?
    var processedDate: Date? = Date()

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case amount, transactionDate
        case transDescription = "description"
        case transactionType, receipient, sender
    }
}

struct Receipient: Codable {
    let accountNo, accountHolder: String
}
