//
//  CircularErrorMessage.swift
//  Bank
//
//  Created by Christian Tanputra on 5/6/2022.
//

import Foundation
import SwiftUI

struct CircularErrorMessage: View {
    
    @Binding var errorText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.backgroundRed)
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(.red, lineWidth: 1)
                )
                .frame(height: 55)
            Text(errorText)
                .bold()
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
