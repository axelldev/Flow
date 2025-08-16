//
//  FlowItem.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import Foundation
import SwiftData

@Model
final class FlowItem {
    @Attribute(.unique) var id: UUID
    var title: String
    var details: String
    var iconSystemName: String
    var isActive: Bool
    var accumulatedSeconds: Int
    var startedAt: Date?
    var createdAt: Date
    var updatedAt: Date
    var parent: Flow?   // inverse relationship
    
    init(
        title: String,
        details: String = "",
        iconSystemName: String = "checkmark.circle",
        parent: Flow? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.details = details
        self.iconSystemName = iconSystemName
        self.isActive = false
        self.accumulatedSeconds = 0
        self.startedAt = nil
        self.createdAt = .now
        self.updatedAt = .now
        self.parent = parent
    }
}
