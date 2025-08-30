//  Flow.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Flow {
    @Attribute(.unique) var id: UUID
    var title: String
    var flowDescription: String
    var items: [FlowItem]
    var createdAt: Date
    var updatedAt: Date
    var iconName: String?
    var colorId: String?

    init(
        title: String,
        flowDescription: String = "",
        iconName: String? = "square.grid.2x2",
        colorId: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.flowDescription = flowDescription
        self.items = []
        self.createdAt = .now
        self.updatedAt = .now
        self.iconName = iconName
        self.colorId = colorId
    }
    
    func getColor() -> Color {
        guard let colorId else { return .gray }
        return SelectableColor.getColorById(id: colorId)
    }
}
