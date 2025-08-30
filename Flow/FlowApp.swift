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

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

@main
struct FlowApp: App {
    // Persisted theme selection
    @AppStorage("appTheme") private var appThemeRawValue: String = AppTheme
        .system.rawValue

    private var currentTheme: AppTheme {
        AppTheme(rawValue: appThemeRawValue) ?? .system
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(currentTheme.colorScheme)
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
                    UserSettingsScreen()
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
