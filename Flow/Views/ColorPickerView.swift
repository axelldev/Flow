//
//  ColorPickerView.swift
//  Flow
//
//  Created by axell solis on 12/08/25.
//

import SwiftUI

struct SelectableColor: Identifiable {
    let rawColor: Color

    var id: String { rawColor.description }
    
    init(rawColor: Color) {
        self.rawColor = rawColor
    }
    
    init(id: String) {
        self.rawColor = SelectableColor.getColorById(id: id)
    }
    
    static var availableColors: [Self] = [
        .init(rawColor: .blue),
        .init(rawColor: .green),
        .init(rawColor: .orange),
        .init(rawColor: .indigo),
        .init(rawColor: .cyan),
        .init(rawColor: .pink),
    ]
    
    static func getColorById(id: String) -> Color {
        availableColors.first(where: { $0.id == id })?.rawColor ?? .gray
    }
}

struct ColorPickerView: View {
    let selectedColor: SelectableColor?
    let onPressColor: (SelectableColor) -> Void

    var rawSelectedColor: Color {
        selectedColor?.rawColor ?? .clear
    }

    var body: some View {
        HStack {
            ForEach(SelectableColor.availableColors) { item in
                Spacer()
                Button {
                    onPressColor(item)
                } label: {
                    Circle()
                        .foregroundStyle(item.rawColor)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .stroke(
                                    selectedColor != nil
                                        && selectedColor?.id == item.id
                                        ? rawSelectedColor : .clear,
                                    lineWidth: 4
                                )
                                .frame(width: 46, height: 46)
                        )
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}

#Preview {
    ColorPickerView(selectedColor: SelectableColor(rawColor: .blue)) { _ in }
}
