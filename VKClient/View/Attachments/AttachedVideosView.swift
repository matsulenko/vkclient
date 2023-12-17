//
//  AttachedVideosView.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct AttachedVideosView: View {
    
    @State var videos: [Video]
    @State var selectedVideo: Video?
    
    var body: some View {
        VStack {
            ForEach(videos.indices, id: \.self) { index in
                HStack {
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
                        .onTapGesture {
                            selectedVideo = videos[index]
                        }
                    Spacer()
                }
            }
        }
        .fullScreenCover(item: $selectedVideo) { sheet in
            VideoView(video: sheet, withXmark: true)
        }
    }
}

#Preview {
    AttachedVideosView(videos: Mocks.shared.videos)
}
