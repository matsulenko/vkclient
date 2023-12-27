//
//  PlaylistTabView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct PlaylistTabView: View {
    
    @State var hasError = false
    var token: String
    var userId: Int?
    let limit = 10
    @State var albumsShown: Int = 0
    
    @State var albums: VideoAlbums?
    
    var body: some View {
        if hasError {
            Text("Something went wrong")
        } else {
            VStack {
                if albums != nil {
                    if albums!.count > 0 {
                        ForEach(albums!.items, id: \.self) { playlist in
                                NavigationLink {
                                    VideoPlaylistView(token: token, playlistName: playlist.title, userId: playlist.ownerId, albumId: playlist.id)
                                } label: {
                                    PlaylistRowView(playlist: playlist)
                                        .frame(height: 250)
                                        .padding(.horizontal, 16)
                                }
                        }
                        
                        if albumsShown < albums!.count {
                            Button(
                                action: {
                                    loadMore()
                                }, label: {
                                    Text("Load more")
                                })
                            .buttonStyle(DefaultButton())
                            .padding(.horizontal, 26)
                        }
                        
                    } else {
                        Text("There are no playlists")
                    }
                }
            }
            .onAppear {
                loadAllAlbums()
            }
        }
    }
    
    private func loadAllAlbums() {
        
        if albumsShown == 0 {
            Responses.shared.getVideoAlbums(token: token, userId: userId, offset: nil, count: limit) { result in
                switch result {
                case .success(let albums):
                    self.albums = albums
                    albumsShown += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
    
    private func loadMore() {
        Responses.shared.getVideoAlbums(token: token, userId: userId, offset: albumsShown, count: limit) { result in
            switch result {
            case .success(let moreAlbums):
                if self.albums != nil {
                    self.albums!.items.append(contentsOf: moreAlbums.items)
                                        
                    albumsShown += limit
                }
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
}

#Preview {
    PlaylistTabView(token: InfoPlist.tokenForPreviews)
}
