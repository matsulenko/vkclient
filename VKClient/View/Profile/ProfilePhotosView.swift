//
//  ProfilePhotosView.swift
//  VKClient
//
//  Created by Matsulenko on 05.12.2023.
//

import SwiftUI

struct ProfilePhotosView: View {
    
    @State var photos: [Photo]
    @State var selectedPhoto: Photo?
    let limit = 9
    
    var body: some View {
        NavigationLink {
            PhotoGalleryView(photos: photos)
        } label: {
            HStack {
                Text("Photos")
                    .foregroundStyle(Color("Text"))
                    .font(.headline)
                Text(String(photos.count))
                    .foregroundStyle(.gray)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal, 16)
        ScrollView(.horizontal) {
            HStack(spacing: 5) {
                ForEach(photos.prefix(limit).indices, id: \.self) { index in
                    Color.clear
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 87)
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
                if photos.count > limit {
                    NavigationLink {
                        PhotoGalleryView(photos: photos)
                    } label: {
                        Color.secondary
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .overlay(
                                Text("All photos")
                                    .font(.headline)
                                    .foregroundStyle(Color("Text"))
                            )
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
            }
            .padding(.horizontal, 16)
            .fullScreenCover(item: $selectedPhoto) { sheet in
                PhotoView(photo: sheet)
            }
        }
    }
}

#Preview {
    ProfilePhotosView(photos: Mocks.shared.photos)
}

