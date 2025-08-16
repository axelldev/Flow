//
//  FlowItemView.swift
//  Flow
//
//  Created by axell solis on 16/08/25.
//

import SwiftUI

struct FlowItemView: View {
    let flow: Flow

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: flow.iconName ?? "brain")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(12)
                .foregroundStyle(
                    SelectableColor.getColorById(
                        id: flow.colorId ?? ""
                    )
                )
                .background(
                    SelectableColor.getColorById(
                        id: flow.colorId ?? ""
                    ).opacity(0.2)
                )
                .clipShape(.circle)

            VStack(alignment: .leading) {
                Text(flow.title)
                    .font(.headline)

                if !flow.flowDescription.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty {
                    Text(flow.flowDescription)
                        .lineLimit(1)
                        .font(.footnote)
                        .truncationMode(.tail)
                }
            }
            Spacer()
            
            Image(systemName: "play.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .opacity(0.2)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(.secondary.opacity(0.2))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    VStack {
        FlowItemView(
            flow: Flow(
                title: "Brainstorm Ideas",
                flowDescription: "Generate creative ideas quickly",
                iconName: "bolt.fill",
                colorId: Color.cyan.description
            )
        )

        FlowItemView(
            flow: Flow(
                title: "Eco Task",
                flowDescription: "Sustainability and green projects",
                iconName: "leaf.fill",
                colorId: Color.green.description
            )
        )
    }
}
