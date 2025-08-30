//
//  FlowFormViewModel.swift
//  Flow
//
//  Created by axell solis on 16/08/25.
//

import Foundation
import SwiftUI

@Observable
final class FlowFormViewModel {
    var title: String
    var description: String
    var selectedIcon: String?
    var selectedColor: SelectableColor?
    private let original: Flow?

    init(editingFlow: Flow? = nil) {
        self.original = editingFlow
        self.title = editingFlow?.title ?? ""
        self.description = editingFlow?.flowDescription ?? ""
        self.selectedIcon = editingFlow?.iconName
        if let id = editingFlow?.colorId {
            self.selectedColor = SelectableColor(id: id)
        }
    }

    var isValid: Bool {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        guard selectedColor != nil else { return false }
        guard selectedIcon != nil else { return false }
        
        return true
    }

    func buildNewFlow() -> Flow {
        Flow(
            title: title,
            flowDescription: description,
            iconName: selectedIcon,
            colorId: selectedColor?.id,
        )
    }

    func applyEditsIfNeeded() -> Flow? {
        guard let flow = original else { return nil }
        flow.title = title.trimmed()
        flow.flowDescription = description
        flow.iconName = selectedIcon
        flow.colorId = selectedColor?.id
        return flow
    }
}

