//
//  EmptyListView.swift
//  Flow
//
//  Created by axell solis on 12/08/25.
//

import Foundation
import SwiftUI

struct EmptyListView: View {
    var onPressCreate: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("You don't have any flows.")
            Button {
               onPressCreate?()
            } label: {
                Label("Create a Flow", systemImage: "plus.circle")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundStyle(.green)
            }
        }
    }
}

#Preview {
    EmptyListView()
}
