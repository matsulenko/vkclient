//
//  PlaylistTabView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct PlaylistTabView: View {
    @State var playlists: [VideoPlaylist]
    
    var body: some View {
        ForEach(playlists) { playlist in
            NavigationLink {
                VideoPlaylistView(videos: playlist.videos, playlistName: playlist.title)
            } label: {
                PlaylistRowView(playlist: playlist)
            }
        }
    }
}

#Preview {
    PlaylistTabView(playlists: Mocks.shared.videoPlaylists)
}
