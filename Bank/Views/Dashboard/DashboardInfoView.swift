//
//  DashboardInfoView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct DashboardInfoView: View {
    
    @Binding var accountInfo: AccountInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("You have")
                .font(.caption)
                .bold()
            Text("\(accountInfo.balance ?? 0, format: .currency(code: "SGD"))")
                .font(.title)
                .bold()
            Text("Account No")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 1)
            Text(accountInfo.accountNo ?? "")
                .font(.subheadline)
                .bold()
            Text("Account Holder")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 1)
            Text("Donald Trump")
                .font(.subheadline)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            CustomRoundedRectangle(tl: 0, tr: 22, bl: 0, br: 22)
                .foregroundColor(.white)
                .shadow(color: .shadowGray, radius: 10, x: 0, y: 1)
                .frame(width: 0.75*UIScreen.main.bounds.width)
        )
        .frame(width: 0.75*UIScreen.main.bounds.width)
    }
}
