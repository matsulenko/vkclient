//
//  AlbumTabView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct AlbumTabView: View {
    
    @State var hasError = false
    var token: String
    var userId: Int?
    let limit = 5
    @State var albumsShown: Int = 0
    
    @State var allAlbums: Albums?
    @State var albums: [Album] = []
    
    var body: some View {
        if hasError {
            Text("Something went wrong")
        } else {
            VStack {
                if allAlbums != nil {
                    if allAlbums!.count > 0 {
                        ForEach(albums, id: \.self) { album in
                            if album.id > -100 {
                                NavigationLink {
                                    PhotoGalleryView(token: token, albumName: album.title, userId: userId, albumId: album.id)
                                } label: {
                                    AlbumRowView(album: album)
                                        .frame(height: 250)
                                }
                            }
                        }
                        
                        if albumsShown < allAlbums!.count {
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
                        Text("There are no albums")
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
            Responses.shared.getAlbums(token: token, userId: userId, needSystem: true) { result in
                switch result {
                case .success(let allAlbumsAsc):
                    let allAlbums = Albums(count: allAlbumsAsc.count, items: allAlbumsAsc.items.reversed())
                    self.allAlbums = allAlbums
                    albumsShown += limit
                    albums += allAlbums.items[0..<limit]
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
    
    private func loadMore() {
        if (albumsShown + limit) > allAlbums!.count {
            albums += allAlbums!.items[albumsShown..<allAlbums!.count]
            albumsShown = allAlbums!.count
        } else {
            albums += allAlbums!.items[albumsShown..<(albumsShown + limit)]
            albumsShown += limit
        }
    }
}

#Preview {
    AlbumTabView(token: InfoPlist.tokenForPreviews)
}
