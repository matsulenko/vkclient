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
    @State var selectedTab: PhotoTab = .photo
    
    let photos: [Photo]
    var albumName: String?
    
    var body: some View {
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
                    case .photo: PhotoTabView(photos: photos)
                    case .album: AlbumTabView(photoGalleries: Mocks.shared.photoGalleries)
                    }
                    
                }
            }
            .navigationTitle(albumName == nil ? "Photos" : albumName!)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PhotoGalleryView(photos: Mocks.shared.photos)
}
