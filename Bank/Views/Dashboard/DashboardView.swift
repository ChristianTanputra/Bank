//
//  DashboardView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var networkObject: Network
    
    @State var accountInfo: AccountInfo = AccountInfo(accountNo: "", balance: 0)
    @State var transactionHistory: TransactionHistory = TransactionHistory(transactions: [Transaction]())
    
    @State var groupedTransactionHistory: [[Transaction]] = []
    
//    @State var testTransHistory: TransactionHistory = TransactionHistory(transactions: [Transaction(transactionID: "123123123123", amount: 100, transactionDate: "2022-05-05T11:02:44.078Z", transDescription: "testing", transactionType: "transfer", receipient: Receipient(accountNo: "123123123", accountHolder: "Bob"), sender: Receipient(accountNo: "123123123123", accountHolder: "Bob")), Transaction(transactionID: "123123123123", amount: 100, transactionDate: "2022-05-05T11:02:44.078Z", transDescription: "testing", transactionType: "transfer", receipient: Receipient(accountNo: "123123123", accountHolder: "Bob"), sender: Receipient(accountNo: "123123123123", accountHolder: "Bob")), Transaction(transactionID: "231231232323232", amount: 10, transactionDate: "2022-04-02T09:19:35.174Z", transDescription: "not testing", transactionType: "received", receipient: Receipient(accountNo: "32323232", accountHolder: "jane"), sender: Receipient(accountNo: "", accountHolder: ""))])
    
    let local = LocalNetwork()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundGray
                    .ignoresSafeArea()
                VStack {
                    DashboardInfoView(accountInfo: $accountInfo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    Text("Your transaction history")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .top])
                    ScrollView {
                        ForEach(separateTransHistorybyDate(), id: \.date) { dailyTransaction in
                            DailyTransactionView(dailyTransaction: dailyTransaction)
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: TransferView().environmentObject(networkObject)) {
                        CircularButtonBase(text: "Make Transfer", preferredButton: true)
                    }
                    .padding(.horizontal)
                }
                .onChange(of: networkObject.token) { tokenString in
                    if !tokenString.isEmpty {
                        accountInfo = local.getAccountInfo(token: tokenString)
                        transactionHistory = local.getTransactionHistory(token: tokenString)
//                        groupedTransactionHistory = separateTransHistorybyDate()
                    }
                }
            }
            .toolbar {
                Button(action: {
                    networkObject.logout()
                }) {
                    Text("Logout")
                        .bold()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension DashboardView {
    func dateSortedTransactionHistory() -> [Transaction] {
        var transactions = [Transaction]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_SG")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        for i in 0..<transactionHistory.transactions.count {
            let date = dateFormatter.date(from: transactionHistory.transactions[i].transactionDate)!
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            
            let finalDate = calendar.date(from: components)
            
            let group = DispatchGroup()
            
            group.enter()
            DispatchQueue.global(qos: .default).async {
                transactionHistory.transactions[i].processedDate = finalDate
                group.leave()
            }
            
            group.wait()
            
            transactions.append(transactionHistory.transactions[i])
        }
        
        return transactions.sorted(by: { $0.processedDate?.compare($1.processedDate!) == .orderedDescending})
    }

    func separateTransHistorybyDate() -> [DailyTransaction] {
        let sortedTransactions = dateSortedTransactionHistory()
        var transactions = [DailyTransaction]()
        
        let groupedTransactions = Dictionary(grouping: sortedTransactions) { (element) -> Date in
            return element.processedDate!
        }
        
        for key in groupedTransactions.keys.sorted() {
            transactions.append(DailyTransaction(date: key, transactions: groupedTransactions[key]!))
        }
        
        return transactions
    }
}
