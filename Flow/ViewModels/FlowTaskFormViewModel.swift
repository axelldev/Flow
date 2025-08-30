//
//  FlowTaskFormViewModel.swift
//  Flow
//
//  Created by axell solis on 21/08/25.
//

import Foundation

@Observable
class FlowTaskFormViewModel {
    var title: String = ""
    var description: String = ""
    var selectedIcon: String?

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func buildFlowTask(parent: Flow) -> FlowItem {
        FlowItem(
            title: title,
            details: description,
            iconSystemName: selectedIcon ?? "brain",
            parent: parent,
        )
    }
}
