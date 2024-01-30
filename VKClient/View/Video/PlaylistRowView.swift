//
//  PlaylistRowView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct PlaylistRowView: View {
    @State var playlist: VideoAlbum
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                if playlist.image == nil {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.additionalColor1, Color.additionalColor2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: proxy.size.width, height: 250)
                        .overlay(
                            VStack {
                                Text(String(playlist.count) + " " + "videos")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                
                                Text(playlist.title)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .lineLimit(nil)
                            }
                        )
                        .padding(.bottom, 10)
                } else {
                    Color.clear
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: 250)
                        .overlay(
                            AsyncImage(url: URL(string: playlist.image!.last!.url)) { image in
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
                                    Text(String(playlist.count) + " " + "videos")
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
}
