//
//  PlaylistRowView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct PlaylistRowView: View {
    @State var playlist: VideoPlaylist
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                playlist.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width - 20, height: 250)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 10)
                VStack {
                    Spacer()
                    HStack {
                        Text(String(playlist.videos.count) + " videos")
                            .foregroundStyle(.white)
                            .background(Color.black.opacity(0.6))
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Text(playlist.title)
                            .foregroundStyle(.white)
                            .background(Color.black.opacity(0.6))
                            .font(.title2)
                        Spacer()
                    }
                }
                .padding()
            }
            .padding(.horizontal, 10)
        }
        .frame(height: 250)
    }
}

#Preview {
    PlaylistRowView(playlist: Mocks.shared.videoPlaylists[0])
}
