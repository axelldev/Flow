//
//  FlowListView.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import SwiftData
import SwiftUI

struct FlowListScreen: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Flow.updatedAt, order: .reverse) private var flows: [Flow]

    @State private var showingForm = false
    @State private var editingFlow: Flow? = nil
    @State private var showingEditForm = false
    @State private var selectedFlow: Flow?

    var body: some View {
        VStack {
            if !flows.isEmpty {
                List {
                    ForEach(flows) { flow in
                        FlowItemView(flow: flow)
                            .listRowInsets(.init())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                selectedFlow = flow
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true)
                        {
                            Button {
                                editingFlow = flow
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                            .swipeActions(
                                edge: .trailing,
                                allowsFullSwipe: true
                            ) {
                                Button(role: .destructive) {
                                    delete(flow)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .listRowSpacing(16)

            } else {
                VStack {
                    Spacer()
                    EmptyListView {
                        showingForm = true
                    }
                    Spacer()
                }
            }
        }
        .sheet(item: $editingFlow, onDismiss: { editingFlow = nil }) { flow in
            NavigationStack {
                FlowFormView(editingFlow: flow) { _ in
                    do {
                        try context.save()
                        editingFlow = nil
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .sheet(isPresented: $showingForm) {
            NavigationStack {
                FlowFormView(editingFlow: editingFlow) { newFlow in
                    context.insert(newFlow)
                }
            }
        }
        .navigationDestination(item: $selectedFlow) {
            flow in
            FlowDetailScreen(
                flow:
                    flow
            )
        }
        .navigationTitle("Flows")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingForm = true
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.white)
                }
                .buttonStyle(.glassProminent)
                .tint(.green.opacity(0.8))
            }
        }
    }

    private func delete(_ flow: Flow) {
        context.delete(flow)
    }
}

#Preview("With items") {
    let preview = Preview()
    preview.addExamples(Flow.sampleFlows)
    return NavigationStack {
        FlowListScreen()
            .modelContainer(preview.modelContainer)
    }
}

#Preview("Empty list") {
    let preview = Preview()
    return NavigationStack {
        FlowListScreen()
            .modelContainer(preview.modelContainer)
    }
}
