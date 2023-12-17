//
//  PhotoTabView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct PhotoTabView: View {
    
    let photos: [Photo]
    @State var selectedPhoto: Photo?
    
    let columns = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(photos.indices, id: \.self) { index in
                Color.clear
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        photos[index].image
                            .resizable()
                            .scaledToFill()
                    ).clipped()
                    .onTapGesture {
                        selectedPhoto = photos[index]
                    }
            }
        }
        .fullScreenCover(item: $selectedPhoto) { sheet in
            PhotoView(photo: sheet)
        }
    }
}

#Preview {
    PhotoTabView(photos: Mocks.shared.photos)
}
