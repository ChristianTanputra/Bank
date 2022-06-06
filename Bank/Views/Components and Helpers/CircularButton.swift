//
//  CircularButton.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct CircularButton: View {
    var text: String
    var preferredButton: Bool = false
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            CircularButtonBase(text: text, preferredButton: preferredButton)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CircularButtonBase: View {
    
    var text: String
    var preferredButton: Bool = false
    
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(preferredButton ? .white : .black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 64)
                    .foregroundColor(preferredButton ? .black : .white)
            )
            .overlay(RoundedRectangle(cornerRadius: 64)
                .stroke(.black, lineWidth: 2)
            )
    }
}
