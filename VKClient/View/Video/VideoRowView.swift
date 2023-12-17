//
//  VideoRowView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import AVKit
import SwiftUI

struct VideoRowView: View {
    @State var player = AVPlayer()
    @State var video: Video
    @State var profile: Profile = Mocks.shared.profile
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    VideoView(video: video)
                } label: {
                    video.preview
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .frame(maxWidth: 700)
                        .clipped()
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay(
                            Text(video.length)
                                .background(Color.black.opacity(0.6))
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .padding(10),
                            alignment: .bottomTrailing
                        )
                        .overlay(
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .shadow(radius: 5)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                        )
                        .padding(0)
                }
                Spacer()
            }
            HStack {
                NavigationLink {
                    ProfileView(profile: profile)
                } label: {
                    video.authorAvatar
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 5)
                        .padding(.trailing, 10)
                    
                }
                
                VStack(spacing: 0) {
                    HStack {
                        NavigationLink {
                            ProfileView(profile: profile)
                        } label: {
                            Text(video.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .foregroundStyle(.text)
                        }
                        Spacer()
                    }
                    HStack {
                        Text(video.authorName + " • " + String(video.views) + " views • " + video.postDate)
                            .font(.footnote)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    VideoRowView(video: Mocks.shared.videos[0])
}
