//
//  BoxTextfield.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct BoxTextfield: View {
    
    var title: String
    var isSecure: Bool = false
    @Binding var text: String
    @Binding var errorText: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                if isSecure {
                    SecureField("", text: $text)
                        .font(.subheadline)
                } else {
                    TextField("", text: $text)
                        .font(.subheadline)
                }
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
            .onChange(of: text) { _ in
                errorText = ""
            }
            Text(errorText)
                .font(.body)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
