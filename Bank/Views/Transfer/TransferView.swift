//
//  TransferView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct TransferView: View {
    
    @EnvironmentObject var networkObject: Network
    
    @State var payeeInfo: PayeeInfo = PayeeInfo(payees: [Payee]())
    
    @State var testPayees: [Payee] = [Payee(id: "616d65d1d1b6fd6f12aeede8", name: "Andy", accountNo: "6554-630-9653"), Payee(id: "616d65d1d1b6fd6f12aeedea", name: "Emmie", accountNo: "7174-429-2937")]
    
    // Payee
    let payeeTitle: String = "Payee"
    @State var chosenPayee: Payee = Payee(id: "", name: "", accountNo: "")
    
    // Amount
    let amountTitle: String = "Amount"
    let amountSecure: Bool = false
    @State var amountText: String = ""
    @State var amountErrorText: String = ""
    
    // Description
    let descriptionTitle: String = "Description"
    @State var descriptionText: String = ""
    @State var descriptionErrorText: String = ""
    
    // Alerts
    @State var showAlert: Bool = false
    
    let local = LocalNetwork()
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .ignoresSafeArea()
            VStack {
                TransferPickerView(title: payeeTitle, payees: testPayees, chosenPayee: $chosenPayee)
                    .padding()
                BoxTextfield(title: amountTitle, isSecure: amountSecure, text: $amountText, errorText: $amountErrorText)
                    .keyboardType(.decimalPad)
                    .padding([.horizontal, .bottom])
                BoxTextEditor(title: descriptionTitle, text: $descriptionText, errorText: $descriptionErrorText)
                    .padding([.horizontal, .bottom])
                Spacer()
                CircularButton(text: "Transfer Now", preferredButton: true) {
                    if amountText.isEmpty {
                        amountErrorText = "Amount cannot be empty"
                    } else {
                        Task {
                            await local.transfer(accountNo: chosenPayee.accountNo, amount: Double(amountText) ?? 0, description: descriptionText)
                        }
                    }
                }
            }
            .navigationTitle("Transfer")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear() {
            payeeInfo = local.getPayeeInfo(token: networkObject.token)
        }
    }
}
