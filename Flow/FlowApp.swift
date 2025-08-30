//
//  FlowApp.swift
//  Flow
//
//  Created by axell solis on 09/08/25.
//

import SwiftData
import SwiftUI

enum Tabs {
    case flows, settings
}

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
    @State private var selectedTab: Tabs = .flows
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Flows", systemImage: "list.bullet", value: .flows) {
                NavigationStack {
                    FlowListScreen()
                        .navigationTitle("Flows")
                }
            }

            Tab("Settings", systemImage: "gearshape", value: .settings) {
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
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    RootView()
}
