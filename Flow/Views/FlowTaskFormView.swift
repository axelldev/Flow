//
//  FlowTaskFormView.swift
//  Flow
//
//  Created by axell solis on 21/08/25.
//

import SwiftUI

struct FlowTaskFormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vm = FlowTaskFormViewModel()
    @State private var showIconPicker = false
    @FocusState private var isFocused: Bool

    let flow: Flow

    let onSubmit: (FlowItem) -> Void

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 28) {
                    TextField("Title", text: $vm.title)
                        .focused($isFocused)

                    TextField("Description", text: $vm.description)
                        .focused($isFocused)

                    Button {
                        withAnimation {
                            showIconPicker.toggle()
                            isFocused = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: vm.selectedIcon ?? "brain")
                                .frame(width: 28, height: 28)
                                .foregroundStyle(
                                    vm.selectedIcon != nil
                                        ? flow.getColor() : .gray
                                )
                            Text("Icon")
                                .foregroundStyle(Color(.label))
                                .fontWeight(.bold)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .frame(width: 28, height: 28)
                                .foregroundStyle(
                                    flow.getColor()
                                )
                        }
                    }
                    .listRowSeparator(.hidden)

                    if showIconPicker {
                        IconPickerView(
                            selectedIcon: vm.selectedIcon,
                            selectedColor: flow.getColor()
                        ) { icon in
                            withAnimation {
                                vm.selectedIcon = icon
                                showIconPicker.toggle()
                            }
                        }
                        .transition(.scale.combined(with: .opacity))
                    }

                }
                .padding(.horizontal, 18)
            }
            .scrollDismissesKeyboard(.immediately)

            Spacer()

            Button {
                submit()
            } label: {
                Text("Save")
                    .fontWeight(.bold)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
            }
            .padding()
            .disabled(!vm.isValid)
            .opacity(!vm.isValid ? 0.3 : 1)
            .buttonStyle(.glassProminent)
            .tint(flow.getColor())
        }
        .navigationTitle("New task")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                   submit()
                }
                .disabled(!vm.isValid)
            }
        }
    }

    func submit() {
        guard vm.isValid else { return }
        let task = vm.buildFlowTask(parent: flow)
        onSubmit(task)
        dismiss()
    }

}

#Preview {
    NavigationStack {
        FlowTaskFormView(
            flow: Flow(
                title: "Hello World",
                flowDescription: "This is a test flow",
                iconName: "brain",
                colorId: "pink",
            )
        ) { _ in

        }
    }
}
