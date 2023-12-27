//
//  SettingsView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import KeychainSwift

struct SettingsView: View {
    
    var themes = ["System", "Light", "Dark"]
    
    @Binding var token: String?
    @Binding var isHidden: Bool
    @Binding var colorScheme: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Hide my status", isOn: $isHidden)
                    if isHidden {
                        Text("Your \"Online\" status is hidden")
                    } else {
                        Text("Your \"Online\" status is shown")
                    }
                }
                Section {
                    Picker("Appearance", selection: $colorScheme) {
                        Text("System")
                            .tag("System")
                        Text("Light")
                            .tag("Light")
                        Text("Dark")
                            .tag("Dark")
                    }
                }
                Section {
                    HStack {
                        Image(systemName: "door.right.hand.open")
                            .font(.title2)
                        Text("Log out")
                            .onTapGesture {
                                KeychainSwift().delete("accessToken")
                                token = nil
                            }
                    }
                }
                .listRowBackground(Color.red.opacity(0.5))
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsView(token: .constant(""), isHidden: .constant(true), colorScheme: .constant("system"))
}
