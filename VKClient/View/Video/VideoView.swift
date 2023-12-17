//
//  VideoView.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @Environment(\.dismiss) var dismiss
    @State var player = AVPlayer()
    @State var video: Video
    @State var comments = Mocks.shared.comments
    @State var withXmark: Bool?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if withXmark == true {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.accent)
                            .padding(20)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                CustomVideoPlayer(resource: video.fileName)
                    .frame(height: 250, alignment: .center)
                    .clipped()
                    .shadow(radius: 10)
                
                HStack {
                    video.authorAvatar
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 5)
                        .padding(.horizontal, 10)
                    VStack(spacing: 0) {
                        HStack {
                            Text(video.title)
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Text(video.authorName + " • " + String(video.views) + " views • " + video.postDate)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                    VStack {
                        Image(systemName: video.liked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(video.liked ? .red : .gray)
                            .onTapGesture {
                                if video.liked {
                                    video.liked = false
                                    video.likes -= 1
                                } else {
                                    video.liked = true
                                    video.likes += 1
                                }
                            }
                        Text(String(video.likes))
                            .foregroundStyle(.gray)
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.top, 10)
                
                HStack {
                    Text(video.description)
                        .font(.footnote)
                    Spacer()
                }
                .padding(10)
                
                if comments.count > 0 {
                    Text("Comments")
                        .font(.headline)
                        .padding(.top, 10)
                    CommentsView(comments: comments)
                } else {
                    Text("There are no comments")
                        .foregroundStyle(.gray)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    VideoView(video: Mocks.shared.videos[0])
}
