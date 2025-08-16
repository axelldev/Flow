//
//  FlowListView.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import SwiftData
import SwiftUI

struct FlowListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Flow.updatedAt, order: .reverse) private var flows: [Flow]

    @State private var showingCreateForm = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                if !flows.isEmpty {
                    ScrollView {
                        LazyVStack {
                            ForEach(flows) { flow in
                                HStack {
                                    Image(systemName: flow.iconName ?? "brain")
                                        .padding(8)
                                        .foregroundStyle(
                                            SelectableColor.getColorById(
                                                id: flow.colorId ?? ""
                                            )
                                        )
                                        .background(
                                            SelectableColor.getColorById(
                                                id: flow.colorId ?? ""
                                            ).opacity(0.3)
                                        )
                                        .clipShape(.circle)

                                    VStack(alignment: .leading) {
                                        Text(flow.title)
                                            .font(.headline)
                                    }
                                    Spacer()
                                    Image(systemName: "play")
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .background(.secondary.opacity(0.2))
                                .clipShape(.rect(cornerRadius: 20))
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        EmptyListView {
                            showingCreateForm = true
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Button {
                showingCreateForm = true
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(.green)
                    .clipShape(.circle)
            }
            .zIndex(100)
            .buttonStyle(.plain)

        }
        .sheet(isPresented: $showingCreateForm) {
            FlowFormView { newFlow in
                context.insert(newFlow)
            }
            .navigationTitle("Flows")
        }
    }
}

#Preview("With items") {
    let preview = Preview()
    preview.addExamples(Flow.sampleFlows)
    return FlowListView()
        .padding()
        .modelContainer(preview.modelContainer)
}

#Preview("Empty list") {
    let preview = Preview()
    return NavigationStack {
        FlowListView()
            .padding()
            .modelContainer(preview.modelContainer)
            .navigationTitle("Flows")
    }
}
