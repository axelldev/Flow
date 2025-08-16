//
//  FlowApp.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import SwiftData
import SwiftUI

@main
struct FlowApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Flow.self, FlowItem.self])
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Flows", systemImage: "list.bullet") {
                NavigationStack {
                    FlowListView()
                        .navigationTitle("Flows")
                }
            }

            Tab("Tasks", systemImage: "play.circle.fill") {
                Text("Tasks")
                    .badge(4)
            }

            Tab("Settings", systemImage: "gear") {
                NavigationStack {
                    List {
                        Section("User") {
                            Text("Update profile")
                        }
                    }
                    .navigationTitle("Settings")
                }
            }
        }
    }
}

#Preview {
    RootView()
}
