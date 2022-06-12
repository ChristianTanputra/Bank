//
//  DailyTransactionView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct DailyTransactionView: View {
    
    var dailyTransaction: DailyTransaction
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundColor(.white)
                .shadow(color: .shadowGray, radius: 10, x: 0, y: 1)
            VStack(alignment: .leading) {
                Text(dailyTransaction.date, style: .date)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.bottom, 1)
                ForEach(dailyTransaction.transactions, id: \.transactionID) { transaction in
                    HStack {
                        Text("\(transaction.receipient?.accountHolder ?? transaction.sender!.accountHolder)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.black)
                        Spacer()
                        Text("\(isReceived(transaction: transaction) ? "" : "-")\(String(format: "%.2f", transaction.amount))")
                            .font(.subheadline)
                            .foregroundColor(isReceived(transaction: transaction) ? .green : .gray)
                    }
                    Text("\(transaction.receipient?.accountNo ?? transaction.sender!.accountNo)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                }
            }
            .padding()
        }
        .padding(.top)
    }
}

extension DailyTransactionView {
    func isReceived(transaction: Transaction) -> Bool {
        guard let _ = transaction.receipient else {
            return true
        }
        
        return false
    }
}
