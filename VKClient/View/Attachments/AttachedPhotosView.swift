//
//  AttachedPhotosView.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct AttachedPhotosView: View {
    
    let columns = [
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading),
        GridItem(.fixed(50), spacing: 1, alignment: .leading)
    ]
    
    @State var photos: [Photo]
    
    @State var selectedPhoto: Photo?
    
    var body: some View {
        VStack {
            HStack {
                photos.first!.image
                    .resizable()
                    .clipped()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                    .onTapGesture {
                        selectedPhoto = photos.first
                    }
                Spacer()
            }
            
            if photos.count > 1 {
                HStack {
                    LazyVGrid(columns: columns) {
                        ForEach(photos.suffix(photos.count - 1).indices, id: \.self) { index in
                            Color.clear
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    photos[index].image
                                        .resizable()
                                        .scaledToFill()
                                ).clipped()
                                .onTapGesture {
                                    selectedPhoto = photos[index]
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                    }
                    .frame(minWidth: 50, maxWidth: 203)
                    Spacer()
                }
            }
        }
        .fullScreenCover(item: $selectedPhoto) { sheet in
            PhotoView(photo: sheet)
        }
    }
}

#Preview {
    AttachedPhotosView(photos: Mocks.shared.photos)
}
