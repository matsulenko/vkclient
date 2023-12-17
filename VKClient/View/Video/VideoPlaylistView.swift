//
//  VideoPlaylistView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

enum VideoTab: String, CaseIterable, Identifiable {
    case video
    case playlist
    
    var id: String { self.rawValue }
}

struct VideoPlaylistView: View {
    @State var selectedTab: VideoTab = .video
    
    let videos: [Video]
    var playlistName: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                if playlistName == nil {
                    Picker(selectedTab.id, selection: $selectedTab) {
                        Text("Videos").tag(VideoTab.video)
                        Text("Playlists").tag(VideoTab.playlist)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ScrollView {
                    switch selectedTab {
                    case .video: VideoTabView(videos: videos)
                    case .playlist: PlaylistTabView(playlists: Mocks.shared.videoPlaylists)
                    }
                    
                }
            }
            .navigationTitle(playlistName == nil ? "Videos" : playlistName!)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    VideoPlaylistView(videos: Mocks.shared.videos)
}

//videoPlaylists

/*
 Автор с аватаркой и должностью и возможностью добавить в друзья,
 Плейлисты,
 Видео
 */
