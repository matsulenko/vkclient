//
//  PostRow.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct PostRow: View {
    
    @State var post: Post
    @State var selectedPhoto: Photo?
    @State var selectedVideo: Video?
    @State private var showingComments = false
    @State var isBookmarked = false
    
    var body: some View {
        
        let avatar: Image = {
            if post.profile.avatar != nil {
                return post.profile.avatar!
            } else {
                return Image("VKClient")
            }
        }()
        
        VStack {
            HStack {
                NavigationLink {
                    ProfileView(profile: post.profile, isMyProfile: false)
                } label: {
                    avatar
                        .resizable()
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 40, height: 40)
                        .shadow(radius: 5)
                }
                VStack {
                    HStack {
                        NavigationLink {
                            ProfileView(profile: post.profile, isMyProfile: false)
                        } label: {
                            Text(post.profile.name + " " + post.profile.surname)
                                .fontWeight(.bold)
                                .font(.footnote)
                                .foregroundStyle(.text)
                        }
                        Spacer()
                    }
                    HStack {
                        Text(post.postDate)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            if post.attachedPhotos != nil {
                AttachedPhotosView(photos: post.attachedPhotos!)
            }
            
            if post.attachedVideos != nil {
                AttachedVideosView(videos: post.attachedVideos!)
            }
            HStack {
                Text(post.description)
                    .font(.footnote)
                Spacer()
            }
            HStack {
                HStack {
                    Image(systemName: post.liked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(post.liked ? .red : .gray)
                        .onTapGesture {
                            if post.liked {
                                post.liked = false
                                post.likes -= 1
                            } else {
                                post.liked = true
                                post.likes += 1
                            }
                        }
                    Text(String(post.likes))
                        .foregroundStyle(.gray)
                }
                Spacer()
                HStack {
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.gray)
                    Text(String(post.comments))
                        .foregroundStyle(.gray)
                }
                .onTapGesture {
                    showingComments = true
                }
                Spacer()
                Image(systemName: "arrowshape.turn.up.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray)
                Spacer()
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 15, height: 20)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        if isBookmarked {
                            isBookmarked = false
                        } else {
                            isBookmarked = true
                        }
                    }
            }
        }
        .padding(16)
        .frame(maxWidth: 700)
        .sheet(isPresented: $showingComments) {
            NavigationStack {
                CommentsView(comments: Mocks.shared.comments)
            }
        }
    }
}

#Preview {
    PostRow(post: Mocks.shared.posts[0])
}
