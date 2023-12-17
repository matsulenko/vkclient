//
//  ContentView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import VKID

struct ContentView: View {
    
    @State private var isLogin = true
    @AppStorage("isSafe") var isSafe = true
    @AppStorage("isSavingLikes") var isSavingLikes = true
    @AppStorage("notificationsAreEnabled") var notificationsAreEnabled = false
    @AppStorage("isHidden") var isHidden = false
    
    var body: some View {
        var vkid = try! self.login()
        
        if isLogin {
            TabView {
                FeedView(feed: Mocks.shared.feed)
                    .tabItem {
                        Label("Main", systemImage: "house.fill")
                    }
                
                VideoPlaylistView(videos: Mocks.shared.videos)
                    .tabItem {
                        Label("Video", systemImage: "film.fill")
                    }
                MessengerView(profiles: Mocks.shared.feed.profiles)
                    .tabItem {
                        Label("Messages", systemImage: "message.fill")
                    }
                ProfileView(profile: Mocks.shared.profile)
                    .tabItem {
                        Label("My profile", systemImage: "person.crop.circle.fill")
                    }
                SettingsView(isSafe: $isSafe, isSavingLikes: $isSavingLikes, notificationsAreEnabled: $notificationsAreEnabled, isHidden: $isHidden)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .frame(maxWidth: 1024)
        }
    }
    
    func login() throws -> VKID {
        let clientId = InfoPlist.clientId
        let clientSecret = InfoPlist.clientSecret
        
        if clientId == nil || clientSecret == nil {
            preconditionFailure("Application data is empty")
        } else {
            do {
                let vkid = try VKID(
                    config: Configuration(
                        appCredentials: AppCredentials(
                            clientId: clientId!,
                            clientSecret: clientSecret!
                        )
                    )
                )
                return vkid
            } catch {
                preconditionFailure("Failed to initialize VKID: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
