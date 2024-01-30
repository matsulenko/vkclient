//
//  PhotoGalleryView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

enum PhotoTab: String, CaseIterable, Identifiable {
    case photo
    case album
    
    var id: String { self.rawValue }
}

struct PhotoGalleryView: View {
    var token: String
    @State var selectedTab: PhotoTab = .photo
    
    var albumName: String?
    var userId: Int?
    var albumId: Int?
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                VStack {
                    if albumName == nil {
                        Picker(selectedTab.id, selection: $selectedTab) {
                            Text("Photos").tag(PhotoTab.photo)
                            Text("Albums").tag(PhotoTab.album)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    ScrollView {
                        switch selectedTab {
                        case .photo: PhotoTabView(token: token, userId: userId, albumId: albumId)
                        case .album: AlbumTabView(token: token, userId: userId)
                                .padding(.horizontal, 16)
                        }
                        
                    }
                }
                .navigationTitle(albumName == nil ? "Photos" : albumName!)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.visible, for: .navigationBar)
            }
        }
    }
}

#Preview {
    PhotoGalleryView(token: InfoPlist.tokenForPreviews)
}
