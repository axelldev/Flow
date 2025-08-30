//
//  FlowDeatilView.swift
//  Flow
//
//  Created by axell solis on 21/08/25.
//

import SwiftData
import SwiftUI

struct FlowDetailScreen: View {
    @Environment(\.modelContext) var context

    let flow: Flow

    @State private var showTaskModal = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CircularIconView(
                    icon: flow.iconName ?? "brain",
                    color: flow.getColor(),
                    size: 24
                )

                Text(flow.title)
                    .font(.title)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            Text(flow.flowDescription)
                .padding(.horizontal)
                .font(.body)
                .foregroundStyle(.secondary)

            List {
                ForEach(flow.items) { item in
                    TaskItemView(task: item) {
                        withAnimation {
                            item.toggle(context: context)
                        }
                    }
                    .listRowInsets(.init())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let item = flow.items[index]
                        context.delete(item)
                    }

                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
            }
            .padding(.top, 8)
            .listStyle(.plain)
            .listRowSpacing(8)
            .scrollContentBackground(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showTaskModal = true
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.white)
                }
                .buttonStyle(.glassProminent)
                .tint(flow.getColor().opacity(0.8))
            }
        }
        .sheet(isPresented: $showTaskModal) {
            NavigationStack {
                FlowTaskFormView(flow: flow) { task in
                    context.insert(task)
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    let flow = Flow.sampleFlows[0]
    let flowItem = FlowItem(
        title: "Flow 1",
        details: "flow example",
        iconSystemName: "brain",
        parent: flow,
    )

    NavigationStack {
        FlowDetailScreen(flow: flow)
    }
}
