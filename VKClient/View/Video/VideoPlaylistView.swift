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
    var token: String
    @State var selectedTab: VideoTab = .video
    
    var playlistName: String?
    var userId: Int?
    var albumId: Int?
    var isSearch = false
    var query: String?
    
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
                    case .video: VideoTabView(token: token, userId: userId, albumId: albumId, isSearch: isSearch, query: query)
                    case .playlist: PlaylistTabView(token: token, userId: userId)
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
    VideoPlaylistView(token: InfoPlist.tokenForPreviews)
}

//videoPlaylists

/*
 Автор с аватаркой и должностью и возможностью добавить в друзья,
 Плейлисты,
 Видео
 */
