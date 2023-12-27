//
//  AlbumRowView.swift
//  VKClient
//
//  Created by Matsulenko on 03.12.2023.
//

import SwiftUI

struct AlbumRowView: View {
    @State var album: Album
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Color.clear
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: 250)
                    .overlay(
                        AsyncImage(url: URL(string: album.sizes.last!.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                    ).clipped()
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Text(String(album.size) + " " + "photos")
                                    .foregroundStyle(.white)
                                    .background(Color.black.opacity(0.6))
                                    .font(.subheadline)
                                Spacer()
                            }
                            HStack {
                                Text(album.title)
                                    .foregroundStyle(.white)
                                    .background(Color.black.opacity(0.6))
                                    .font(.title2)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack {
                                Text(album.description ?? "")
                                    .foregroundStyle(.white)
                                    .background(Color.black.opacity(0.6))
                                    .font(.caption)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                            .padding(16)
                    )
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.bottom, 10)
                VStack {
                    
                }
            }
        }
    }
}

#Preview {
    AlbumRowView(album: Album(id: 163556136, ownerId: 220458, size: 82, title: "Нижний Новгород - 2012", created: 1349285663, description: "", sizes: [AlbumSize(type: "z", url: "https://sun9-16.userapi.com/impf/pn-tUYK0zRWQbW5oA5UkqufOdIM9u5yoO5TdFQ/5gGA3Tg3OEg.jpg?size=1280x960&quality=96&sign=01035f74224afda9781ce292cf8abc6a&c_uniq_tag=i7HEW8xNYtBX6MKctsq1b57YrFzsusoREcuePh5-j40&type=album")]))
}
