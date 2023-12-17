//
//  SettingsView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isSafe: Bool
    @Binding var isSavingLikes: Bool
    @Binding var notificationsAreEnabled: Bool
    @Binding var isHidden: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Save liked content", isOn: $isSavingLikes)
                    if isSavingLikes {
                        Text("VK Client saves content that you like using this app")
                    } else {
                        Text("VK Client does not save any content")
                    }
                }
                Section {
                    Toggle("Notifications", isOn: $notificationsAreEnabled)
                    if notificationsAreEnabled {
                        Text("Notifications are enabled")
                    } else {
                        Text("Notifications are disabled")
                    }
                }
                Section {
                    Toggle("Hide my status", isOn: $isHidden)
                    if isHidden {
                        Text("Your \"Online\" status is hidden")
                    } else {
                        Text("Your \"Online\" status is shown")
                    }
                }
                Section {
                    Toggle("Safe mode", isOn: $isSafe)
                    if isSafe {
                        Text("Content for adults is hidden")
                    } else {
                        Text("Content for adults can be shown")
                    }
                }
            }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(isSafe: .constant(true), isSavingLikes: .constant(true), notificationsAreEnabled: .constant(false), isHidden: .constant(false))
}
