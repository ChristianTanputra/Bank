//
//  LocalNetwork.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation
import SwiftUI

class LocalNetwork {
    
    let websiteURL: String = "https://green-thumb-64168.uc.r.appspot.com"
    
    // Returns token
    func login(username: String, password: String) async -> String {
        let localUser: LocalUser = LocalUser(username: username, password: password)
        
        guard let encoded = try? JSONEncoder().encode(localUser) else {
            print("Failed to encode user")
            return ""
        }
        
        let url = URL(string: "\(websiteURL)/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(User.self, from: data)
            if decoded.status == "success" {
                return decoded.token!
            } else {
                print("Login failed")
            }
        } catch {
            print("Error")
        }
        
        return ""
    }
    
    // Returns token
    func register(username: String, password: String) async -> String {
        let localUser: LocalUser = LocalUser(username: username, password: password)
        
        guard let encoded = try? JSONEncoder().encode(localUser) else {
            print("Failed to encode user")
            return ""
        }
        
        let url = URL(string: "\(websiteURL)/register")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(User.self, from: data)
            if decoded.status == "success" {
                return decoded.token!
            } else {
                print("Register failed")
            }
        } catch let error {
            print(error)
        }
        
        return ""
    }
    
    func getAccountInfo(token: String) async -> AccountInfo {
        var accountInfo = AccountInfo(accountNo: "", balance: 0)
        
        let url = URL(string: "\(websiteURL)/balance")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(AccountInfo.self, from: data)
            accountInfo = decoded
        } catch let error {
            print(error)
        }
        
        return accountInfo
    }
    
    func getTransactionHistory(token: String) async -> TransactionHistory {
        var transactionHistory = TransactionHistory(transactions: [Transaction]())
        
        let url = URL(string: "\(websiteURL)/transactions")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(TransactionHistory.self, from: data)
            transactionHistory = decoded
        } catch let error {
            print(error)
        }
        
        return transactionHistory
    }
    
    func getPayeeInfo(token: String) async -> PayeeInfo {
        var payeeInfo = PayeeInfo(payees: [Payee]())
        
        let url = URL(string: "\(websiteURL)/payees")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(PayeeInfo.self, from: data)
            print(payeeInfo)
            payeeInfo = decoded
        } catch let error {
            print(error)
        }
        
        return payeeInfo
    }
    
    func transfer(token: String, accountNo: String, amount: Double, description: String) async -> TransferInfo {
        let localTransferInfo: LocalTransferInfo = LocalTransferInfo(receipientAccountNo: accountNo, amount: amount, description: description)
        var transferInfo: TransferInfo = TransferInfo(status: "", transactionId: "", amount: 0, description: "", recipientAccount: "")
        
        guard let encoded = try? JSONEncoder().encode(localTransferInfo) else {
            print("Failed to encode")
            return transferInfo
        }
        
        let url = URL(string: "\(websiteURL)/transfer")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(TransferInfo.self, from: data)
            transferInfo = decoded
        } catch let error {
            print(error)
        }
        
        return transferInfo
    }
}
