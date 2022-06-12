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
    
    // Page error
    @State var errorText: String = ""
    
    // Alerts
    @State var showAlert: Bool = false
    @State var alertText: String = ""
    
    let local = LocalNetwork()
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .ignoresSafeArea()
            VStack {
                if !payeeInfo.payees.isEmpty {
                TransferPickerView(title: payeeTitle, payees: payeeInfo.payees, chosenPayee: $chosenPayee)
                    .padding()
                }
                BoxTextfield(title: amountTitle, isSecure: amountSecure, text: $amountText, errorText: $amountErrorText)
                    .keyboardType(.decimalPad)
                    .padding([.horizontal, .bottom])
                BoxTextEditor(title: descriptionTitle, text: $descriptionText, errorText: $descriptionErrorText)
                    .padding([.horizontal, .bottom])
                if !errorText.isEmpty {
                    CircularErrorMessage(errorText: $errorText)
                        .padding([.horizontal, .bottom])
                }
                Spacer()
                CircularButton(text: "Transfer Now", preferredButton: true) {
                    if amountText.isEmpty {
                        amountErrorText = "Amount cannot be empty"
                    } else {
                        Task {
                            let transactionResult = await local.transfer(token: networkObject.token, accountNo: chosenPayee.accountNo, amount: Double(amountText) ?? 0, description: descriptionText)
                            if transactionResult.status == "success" {
                                showAlert = true
                                alertText = generateSuccessString(result: transactionResult)
                            } else {
                                errorText = transactionResult.error ?? "Transfer failed. Try again later."
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Transfer Success"), message: Text(alertText), dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle("Transfer")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear() {
            Task {
                payeeInfo = await local.getPayeeInfo(token: networkObject.token)
            }
        }
    }
}

extension TransferView {
    func generateSuccessString(result: TransferInfo) -> String {
        let amount = String(format: "$%.02f", result.amount ?? 0)
        let transID = result.transactionId ?? ""
        return "An amount of \(amount) was successfully transfered. Transaction ID: \(transID). Thank you for using Bank."
    }
}
