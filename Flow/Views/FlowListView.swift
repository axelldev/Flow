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
    @State private var editingFlow: Flow? = nil
    @State private var showingEditForm = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                if !flows.isEmpty {
                    List {
                        ForEach(flows) { flow in
                            FlowItemView(flow: flow)
                                .listRowSeparator(.hidden)
                                .listRowInsets(.init())
                                .swipeActions(
                                    edge: .trailing,
                                    allowsFullSwipe: false
                                ) {
                                    Button {
                                        context.delete(flow)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)

                                    Button {
                                        editingFlow = flow
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.orange)

                                }
                        }
                        .onMove { indices, newOffset in
                            var reordered = flows
                            reordered.move(
                                fromOffsets: indices,
                                toOffset: newOffset
                            )
                        }
                    }
                    .padding(.horizontal, 8)
                    .listStyle(.plain)
                    .listRowSpacing(8)
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        EditButton()
                    }
                    .safeAreaInset(edge: .bottom) {
                        Spacer().frame(height: 80)
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
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Button {
                editingFlow = nil
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
        }
        .sheet(item: $editingFlow) { flow in
            FlowFormView(editingFlow: flow) { _ in
                try? context.save()
            }
        }.onTapGesture {
            editingFlow = nil
        }
    }

    private func delete(_ flow: Flow) {
        context.delete(flow)
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
            .modelContainer(preview.modelContainer)
            .navigationTitle("Flows")
    }
}
