//
//  ContentView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import KeychainSwift

struct ContentView: View {
    
    @Environment(\.colorScheme) var systemColorScheme
    @State var token = KeychainSwift().get("accessToken")
    @AppStorage("colorScheme") var colorScheme = "System"
    
    var body: some View {
        if token != nil {
            MainTabView(token: $token, colorScheme: $colorScheme)
                .preferredColorScheme(getColorScheme(colorScheme: colorScheme))
                .frame(maxWidth: 900)
        } else {
            WebView(token: $token)
                .ignoresSafeArea()
        }
    }
    
    private func getColorScheme(colorScheme: String) -> ColorScheme? {
        if colorScheme == "Dark" {
            return .dark
        } else if colorScheme == "Light" {
            return .light
        } else {
            return nil
        }
    }
}

#Preview {
    ContentView()
}
