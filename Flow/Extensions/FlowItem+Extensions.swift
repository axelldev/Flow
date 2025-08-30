//
//  FlowItem+Extensions.swift
//  Flow
//
//  Created by axell solis on 29/08/25.
//
import Foundation
import SwiftData

extension FlowItem {
    var totalElapsedSeconds: Int {
        guard isActive, let startedAt else { return accumulatedSeconds }
        let running = Int(Date().timeIntervalSince(startedAt))
        return accumulatedSeconds + max(0, running)
    }
    
    func start(context: ModelContext) {
        guard !isActive else { return }
        isActive = true
        startedAt = Date()
        updatedAt = Date()
        try? context.save()
    }
    
    func stop(context: ModelContext) {
        guard isActive, let startedAt else { return }
        let delta = Int(Date().timeIntervalSince(startedAt))
        accumulatedSeconds += max(0, delta)
        isActive = false
        self.startedAt = nil
        updatedAt = Date()
        try? context.save()
    }
    
    func toggle(context: ModelContext) {
        isActive ? stop(context: context) : start(context: context)
    }
}
