//
//  CommentsRow.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import SwiftUI

struct CommentsRow: View {
    
    @State var comment: Comment
    @State var profile = Mocks.shared.profile
    var onReplyTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            VStack {
                NavigationLink {
                    ProfileView(profile: profile, isMyProfile: false)
                } label: {
                    comment.authorAvatar
                        .resizable()
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 40, height: 40)
                        .shadow(radius: 5)
                        .padding(.leading, comment.isReply ? 20 : 0)
                }
                Spacer()
            }
            VStack {
                HStack {
                    NavigationLink {
                        ProfileView(profile: profile, isMyProfile: false)
                    } label: {
                        Text(comment.authorName)
                            .fontWeight(.bold)
                            .font(.footnote)
                            .foregroundStyle(.text)
                    }
                    Text(comment.postDate)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text(comment.text)
                        .font(.footnote)
                    Spacer()
                }
                
                if comment.attachedPhotos != nil {
                    AttachedPhotosView(photos: comment.attachedPhotos!)
                }
                
                if comment.attachedVideos != nil {
                    AttachedVideosView(videos: comment.attachedVideos!)
                }
                
                HStack {
                    Text("Reply")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.footnote)
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            onReplyTapped?()
                        }
                    Spacer()
                }
            }
            .padding(.leading, 5)
            VStack {
                Image(systemName: comment.liked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(comment.liked ? .red : .gray)
                    .padding(.top, 10)
                    .onTapGesture {
                        if comment.liked {
                            comment.liked = false
                            comment.likes -= 1
                        } else {
                            comment.liked = true
                            comment.likes += 1
                        }
                    }
                Text(String(comment.likes))
                    .font(.footnote)
                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    CommentsRow(comment: Mocks.shared.commentWithPhotos)
}
