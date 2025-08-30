//
//  CircularButton.swift
//  Flow
//
//  Created by axell solis on 21/08/25.
//

import SwiftUI

struct CircularButton: View {
    var label: String
    var icon: String
    var color: Color = .gray
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(label, systemImage: icon)
                .labelStyle(.iconOnly)
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
        }
        .glassEffect(.regular.tint(color.opacity(0.8)).interactive())
    }
}

#Preview {
    CircularButton(label: "Add flow", icon: "plus") {}
}
