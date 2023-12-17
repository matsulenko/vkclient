//
//  AlbumTabView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct AlbumTabView: View {
    @State var photoGalleries: [PhotoGallery]
    
    var body: some View {
        ForEach(photoGalleries) { photoGallery in
            NavigationLink {
                PhotoGalleryView(selectedTab: .photo, photos: photoGallery.photos, albumName: photoGallery.title)
            } label: {
                AlbumRowView(gallery: photoGallery)
            }
        }
    }
}

#Preview {
    AlbumTabView(photoGalleries: Mocks.shared.photoGalleries)
}
