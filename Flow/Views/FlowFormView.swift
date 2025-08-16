//
//  FlowFormView.swift
//  Flow
//
//  Created by axell solis on 12/08/25.
//

import SwiftUI


struct FlowFormView: View {
    let lineHeight: CGFloat = 20
    let lineLimit: Int = 3
    let onSubmit: (Flow) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var flowDescription = ""
    @State private var selectedIcon: String? = nil
    @State private var showIconPicker = false
    @State private var selectedColor: SelectableColor? = nil

    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                    .listRowSeparator(.hidden)

                TextField("Description", text: $flowDescription)

                Button {
                    withAnimation {
                        showIconPicker.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: selectedIcon ?? "brain")
                            .frame(width: 28, height: 28)
                            .foregroundStyle(selectedColor?.rawColor ?? .orange)
                        Text("Icon")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .frame(width: 28, height: 28)
                            .foregroundStyle(selectedColor?.rawColor ?? .orange)
                    }
                }
                .listRowSeparator(.hidden)

                if showIconPicker {
                    IconPickerView(
                        selectedIcon: selectedIcon,
                        selectedColor: selectedColor?.rawColor ?? .orange
                    ) { icon in
                        withAnimation {
                            selectedIcon = icon
                            showIconPicker.toggle()
                        }
                    }
                }

                ColorPickerView(selectedColor: selectedColor) { value in
                    withAnimation(.bouncy) {
                        selectedColor = value
                    }
                }
            }

            Spacer()

            Button {
                submit()
            } label: {
                Text("Create Flow")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.orange)
                    .clipShape(.rect(cornerRadius: 8))
            }
            .padding()
        }
    }

    func isValid() -> Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func submit() {
        guard isValid() else { return }

        let flow = Flow(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            flowDescription: flowDescription,
            iconName: selectedIcon,
            colorId: selectedColor?.id
        )

        onSubmit(flow)
        dismiss()
    }

}

#Preview {
    NavigationStack {
        FlowFormView { _ in }
            .padding()
    }
}
