//
//  CircularIconView.swift
//  Flow
//
//  Created by axell solis on 21/08/25.
//

import SwiftUI

struct CircularIconView: View {
    let icon: String
    let color: Color
    var size: CGFloat = 36
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding(12)
            .foregroundStyle(color)
            .background(color.opacity(0.2))
            .clipShape(.circle)
    }
}

#Preview {
    CircularIconView(
        icon: "brain",
        color: .blue
    )
}
