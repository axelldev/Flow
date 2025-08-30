//
//  FlowFormView.swift
//  Flow
//
//  Created by axell solis on 12/08/25.
//

import SwiftUI

struct FlowFormView: View {
    var editingFlow: Flow?
    let onSubmit: (Flow) -> Void

    var title: String {
        editingFlow != nil ? "Editing Flow" : "New Flow"
    }

    @Environment(\.dismiss) var dismiss
    @State private var vm: FlowFormViewModel
    @State private var showIconPicker: Bool = false
    @FocusState private var isFocused: Bool

    init(editingFlow: Flow? = nil, onSubmit: @escaping (Flow) -> Void) {
        self.editingFlow = editingFlow
        self.onSubmit = onSubmit
        _vm = State(wrappedValue: FlowFormViewModel(editingFlow: editingFlow))
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.title)

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
                                    vm.selectedColor?.rawColor ?? .gray
                                )
                            Text("Icon")
                                .foregroundStyle(Color(.label))
                                .fontWeight(.bold)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .frame(width: 28, height: 28)
                                .foregroundStyle(
                                    vm.selectedColor?.rawColor ?? .gray
                                )
                        }
                    }
                    .listRowSeparator(.hidden)

                    ColorPickerView(selectedColor: vm.selectedColor) { value in
                        withAnimation(.bouncy) {
                            vm.selectedColor = value
                        }
                    }

                    if showIconPicker {
                        IconPickerView(
                            selectedIcon: vm.selectedIcon,
                            selectedColor: vm.selectedColor?.rawColor ?? .gray
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
            .tint(vm.selectedColor?.rawColor ?? .clear)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { submit() }) {
                    Text("Save")
                }
                .disabled(!vm.isValid)
            }
        }
    }

    func submit() {
        guard vm.isValid else { return }

        if let edited = vm.applyEditsIfNeeded() {
            onSubmit(edited)
        } else {
            onSubmit(vm.buildNewFlow())
        }

        dismiss()
    }

}

#Preview {
    NavigationStack {
        FlowFormView { _ in }
            .padding()
    }
}
