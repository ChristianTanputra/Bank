//
//  DashboardView.swift
//  Bank
//
//  Created by Christian Tanputra on 1/6/2022.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Logout")
                            .bold()
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
