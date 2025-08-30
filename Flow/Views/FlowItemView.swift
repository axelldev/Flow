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
        HStack {
            CircularIconView(
                icon: flow.iconName ?? "brain",
                color: flow.getColor(),
                size: 24
            )
            .glassEffect()

            VStack(alignment: .leading) {
                Text(flow.title)
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(1)
                    .truncationMode(.tail)

                if !flow.flowDescription.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty {
                    Text(flow.flowDescription)
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }

            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
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
