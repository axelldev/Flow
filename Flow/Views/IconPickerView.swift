//
//  IconPickerView.swift
//  Flow
//
//  Created by axell solis on 12/08/25.
//

import SwiftUI

struct IconPickerView: View {
    var selectedIcon: String?
    var selectedColor: Color = .orange

    let onPressIcon: (String) -> Void

    let iconCategories: [String: [String]] = [
        "Coding": [
            "chevron.left.slash.chevron.right",
            "terminal.fill",
            "curlybraces",
            "hammer.fill",
            "laptopcomputer",
        ],
        "Productivity": [
            "calendar.badge.clock",
            "list.bullet.rectangle.portrait.fill",
            "flag.fill",
            "checkmark.circle.fill",
            "clock.fill",
        ],
        "Communication": [
            "bubble.left.and.bubble.right.fill",
            "envelope.fill",
            "bell.fill",
            "paperplane.fill",
            "phone.fill",
        ],
        "Files": [
            "tray.full.fill",
            "folder.fill",
            "doc.text.fill",
            "macwindow.badge.plus",
            "externaldrive.fill",
        ],
        "Design": [
            "paintbrush.fill",
            "slider.horizontal.3",
            "rectangle.3.offgrid.bubble.left.fill",
            "chart.bar.fill",
            "scribble.variable",
        ],
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(iconCategories.sorted(by: { $0.key < $1.key }), id: \.key) {
                category,
                icons in
                Text(category)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                HStack {
                    ForEach(icons, id: \.self) { icon in
                        Spacer()
                        Button {
                            onPressIcon(icon)
                        } label: {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .padding(7)
                                .background(
                                    selectedIcon == icon
                                        ? selectedColor.opacity(0.2)
                                        : Color.clear
                                )
                                .clipShape(Circle())
                                .foregroundStyle(
                                    selectedIcon == icon
                                        ? selectedColor : .primary
                                )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Circle())
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    IconPickerView(
        selectedIcon: "chevron.left.slash.chevron.right",
        selectedColor: .blue,
        onPressIcon: { _ in }
    )
}
