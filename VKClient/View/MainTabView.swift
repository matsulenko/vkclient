//
//  MainTabView.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import SwiftUI

struct MainTabView: View {
    
    var token: String
    @AppStorage("isSafe") var isSafe = true
    @AppStorage("isSavingLikes") var isSavingLikes = true
    @AppStorage("notificationsAreEnabled") var notificationsAreEnabled = false
    @AppStorage("isHidden") var isHidden = false
    
    var body: some View {
        TabView {
            FeedView(feed: Mocks.shared.feed)
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
            VideoPlaylistView(videos: Mocks.shared.videos)
                .tabItem {
                    Label("Video", systemImage: "film.fill")
                }
//            MessengerView(profiles: Mocks.shared.feed.profiles)
//                .tabItem {
//                    Label("Messages", systemImage: "message.fill")
//                }
            ProfileView(profile: Mocks.shared.profile)
                .tabItem {
                    Label("My profile", systemImage: "person.crop.circle.fill")
                }
            SettingsView(isSafe: $isSafe, isSavingLikes: $isSavingLikes, notificationsAreEnabled: $notificationsAreEnabled, isHidden: $isHidden)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView(token: "")
}
