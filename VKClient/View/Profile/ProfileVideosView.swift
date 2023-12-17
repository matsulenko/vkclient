//
//  ProfileVideosView.swift
//  VKClient
//
//  Created by Matsulenko on 05.12.2023.
//

import SwiftUI

struct ProfileVideosView: View {
    
    @State var videos: [Video]
    let limit = 5
    
    var body: some View {
        NavigationLink {
            VideoPlaylistView(videos: videos)
        } label: {
            HStack {
                Text("Videos")
                    .foregroundStyle(Color("Text"))
                    .font(.headline)
                Text(String(videos.count))
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
                ForEach(videos.prefix(limit).indices, id: \.self) { index in
                    NavigationLink {
                        VideoView(video: videos[index])
                    } label: {
                        
                        Color.clear
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 90)
                            .overlay(
                                videos[index].preview
                                    .resizable()
                                    .scaledToFill()
                            ).clipped()
                            .clipShape(.rect(cornerRadius: 15))
                            .overlay(
                                Text(videos[index].length)
                                    .background(Color.black.opacity(0.6))
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .padding(10),
                                alignment: .bottomTrailing
                            )
                            .overlay(
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .shadow(radius: 5)
                                    .foregroundStyle(.white)
                                    .opacity(0.5)
                            )
                    }
                }
                if videos.count > limit {
                    NavigationLink {
                        VideoPlaylistView(videos: videos)
                    } label: {
                        Color.secondary
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 90)
                            .overlay(
                                Text("All videos")
                                    .font(.headline)
                                    .foregroundStyle(Color("Text"))
                            )
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ProfileVideosView(videos: Mocks.shared.videos)
}
