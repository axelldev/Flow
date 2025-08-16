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

    @Environment(\.dismiss) var dismiss
    @State private var vm: FlowFormViewModel
    @State private var showIconPicker: Bool = false
    
    init(editingFlow: Flow? = nil, onSubmit: @escaping (Flow) -> Void) {
        self.editingFlow = editingFlow
        self.onSubmit = onSubmit
        _vm = State(wrappedValue: FlowFormViewModel(editingFlow: editingFlow))
    }

    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $vm.title)
                    .listRowSeparator(.hidden)

                TextField("Description", text: $vm.description)

                Button {
                    withAnimation {
                        showIconPicker.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: vm.selectedIcon ?? "brain")
                            .frame(width: 28, height: 28)
                            .foregroundStyle(
                                vm.selectedColor?.rawColor ?? .orange
                            )
                        Text("Icon")
                            .foregroundStyle(Color(.label))
                            .fontWeight(.bold)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .frame(width: 28, height: 28)
                            .foregroundStyle(
                                vm.selectedColor?.rawColor ?? .orange
                            )
                    }
                }
                .listRowSeparator(.hidden)

                if showIconPicker {
                    IconPickerView(
                        selectedIcon: vm.selectedIcon,
                        selectedColor: vm.selectedColor?.rawColor ?? .orange
                    ) { icon in
                        withAnimation {
                            vm.selectedIcon = icon
                            showIconPicker.toggle()
                        }
                    }
                }

                ColorPickerView(selectedColor: vm.selectedColor) { value in
                    withAnimation(.bouncy) {
                        vm.selectedColor = value
                    }
                }

                Spacer()
                    .listRowSeparator(.hidden)

                Button {
                    submit()
                } label: {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.orange)
                        .clipShape(.rect(cornerRadius: 8))
                }
                .padding()
                .disabled(!vm.isValid)
                .opacity(!vm.isValid ? 0.5 : 1)
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
