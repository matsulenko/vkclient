//
//  AlbumRowView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct AlbumRowView: View {
    @State var gallery: PhotoGallery
    
    var body: some View {
        ZStack {
            gallery.photos.first?.image
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
                .clipShape(.rect(cornerRadius: 15))
            VStack {
                Spacer()
                HStack {
                    Text(String(gallery.photos.count) + " photos")
                        .foregroundStyle(.white)
                        .background(Color.black.opacity(0.6))
                        .font(.subheadline)
                    Spacer()
                }
                HStack {
                    Text(gallery.title)
                        .foregroundStyle(.white)
                        .background(Color.black.opacity(0.6))
                        .font(.title2)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: 250)
        .padding(.horizontal, 10)
    }
}

#Preview {
    AlbumRowView(gallery: Mocks.shared.photoGalleries[0])
}
