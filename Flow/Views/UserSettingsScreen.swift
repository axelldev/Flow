//
//  UserSettingsView.swift
//  Flow
//
//  Created by axell solis on 30/08/25.
//

import SwiftUI

struct UserSettingsScreen: View {
    @AppStorage("appTheme") private var appThemeRawValue: String = AppTheme.system.rawValue

    private var selectedTheme: AppTheme {
        get { AppTheme(rawValue: appThemeRawValue) ?? .system }
        set { appThemeRawValue = newValue.rawValue }
    }

    var body: some View {
        List {
            Section("Appearance") {
                Picker("Theme", selection: Binding(
                    get: { selectedTheme },
                    set: { selectedTheme in
                        appThemeRawValue = selectedTheme.rawValue
                    })
                ) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.displayName).tag(theme)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    NavigationStack {
        UserSettingsScreen()
            .navigationTitle("Settings")
    }
}

