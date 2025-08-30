//
//  TaskItemView.swift
//  Flow
//
//  Created by axell solis on 29/08/25.
//

import SwiftUI

struct TaskItemView: View {
    let task: FlowItem
    let onPressAction: () -> Void
    
    var activeColor: Color {
        task.isActive ? task.parent?.getColor() ?? .secondary : .secondary.opacity(0.5)
    }
    
    var icon: String {
        !task.isActive ? "play.circle.fill" : "pause.circle.fill"
    }
    

    var body: some View {
        HStack {
            CircularIconView(
                icon: task.iconSystemName,
                color: activeColor,
                size: 24
            )
            .glassEffect()

            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text(task.details)
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            Spacer()
            
            Button(action: onPressAction) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.primary.opacity(0.8))
            }
            .buttonStyle(.glassProminent)
            .tint(task.isActive ? activeColor.opacity(0.8) : .secondary.opacity(0.5))
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
}

struct TaskItemViewContainer: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { index in
                TaskItemView(task: generateTask(index)) {
                }
                    .padding()
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }

    func generateTask(_ index: Int) -> FlowItem {
        let item = FlowItem(
            title: "Task \(index)",
            details: "Task details \(index)",
            iconSystemName: "\(index).circle",
            parent: Flow(
                title: "Parent",
                flowDescription: "",
                iconName: "brain",
                colorId: SelectableColor.availableColors.randomElement()?.id,
            )
        )
        item.isActive = .random()
        
        return item
    }
}

#Preview {
    TaskItemViewContainer()
}
