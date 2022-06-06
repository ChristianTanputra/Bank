//
//  TransferPickerView.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation
import SwiftUI

struct TransferPickerView: View {
    
    var title: String
    var payees: [Payee]
    @Binding var chosenPayee: Payee
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                HStack {
                    Picker("", selection: $chosenPayee) {
                        ForEach(payees, id: \.self) { payee in
                            HStack {
                            Text(payee.name)
                                .font(.subheadline)
                                .bold()
                                Spacer()
                            }
                            .background(Color.white)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(6)
            .background(
                Rectangle()
                    .foregroundColor(.white)
            )
            .overlay(
                Rectangle()
                    .stroke(.black, lineWidth: 3)
            )
        }
    }
}
