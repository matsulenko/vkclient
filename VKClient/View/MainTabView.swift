//
//  MainTabView.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @Binding var token: String?
    @AppStorage("isHidden") var isHidden = true
    @Binding var colorScheme: String
    
    var body: some View {
        TabView {
            if token != nil {
                FeedView(token: token!)
                    .tabItem {
                        Label("Feed", systemImage: "house.fill")
                    }
                SearchView(token: token!)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ProfileView(token: token!)
                    .tabItem {
                        Label("My profile", systemImage: "person.crop.circle.fill")
                    }
                SavedPostsView(token: token!)
                    .tabItem {
                        Label("Saved posts", systemImage: "bookmark.fill")
                    }
                SettingsView(token: $token, isHidden: $isHidden, colorScheme: $colorScheme)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        }
        .frame(maxWidth: 900)
    }
}

#Preview {
    MainTabView(token: .constant(InfoPlist.tokenForPreviews), colorScheme: .constant("System"))
}
