//
//  CommentsRow.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import SwiftUI

struct CommentsRow: View {
    @State var hasError = false
    var token: String
    var objectType: ObjectType
    var commentedType: ObjectType
    @State var comment: Comment
    var canComment: Bool
    @State var profile: CommentProfile?
    @State var group: CommentGroup?
    var onReplyTapped: (() -> Void)?
    @State var isDeleted: Bool = false
    
    var body: some View {
        if hasError {
            Text("Something went wrong")
        } else {
            let name: String = {
                if profile != nil {
                    return profile!.firstName + " " + profile!.lastName
                } else if group != nil {
                    return group!.name
                } else {
                    return ""
                }
            }()
            
            let id: Int? = {
                if profile != nil {
                    return profile!.id
                } else if group != nil {
                    if group!.id < 0 {
                        return group!.id
                    } else {
                        return group!.id * (-1)
                    }
                } else {
                    return nil
                }
            }()
            
            let avatarUrl: String = {
                if profile != nil {
                    return profile!.photo
                } else if group != nil {
                    return group!.photo
                } else {
                    return ""
                }
            }()
            
            if isDeleted {
                Divider()
                Text("This comment was deleted")
                    .foregroundStyle(.text)
                Divider()
            } else {
                HStack {
                    VStack {
                        NavigationLink {
                            ProfileView(token: token, userId: id)
                        } label: {
                            AsyncImage(url: URL(string: avatarUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .frame(width: 40, height: 40)
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Spacer()
                    }
                    VStack {
                        HStack {
                            NavigationLink {
                                ProfileView(token: token, userId: id)
                            } label: {
                                Text(name)
                                    .fontWeight(.bold)
                                    .font(.footnote)
                                    .foregroundStyle(.text)
                            }
                            Spacer()
                        }
                        HStack {
                            Text(comment.text)
                                .font(.footnote)
                            Spacer()
                        }
                        if let attachments = comment.attachments {
                            if let attachedLinks = Attachments.shared.attachedLinks(attachments: attachments) {
                                AttachedLinksView(token: token, links: attachedLinks)
                            }
                            if let attachedPhotos = Attachments.shared.attachedPhotos(attachments: attachments) {
                                AttachedPhotosView(token: token, photoAttachments: attachedPhotos)
                            }
                            if let attachedVideos = Attachments.shared.attachedVideos(attachments: attachments) {
                                AttachedVideosView(token: token, videos: attachedVideos)
                            }
                        }
                        
                        HStack {
                            Text(Date(unixTime: comment.date).longDateWithTime)
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                            Spacer()
                        }

                        if canComment {
                            HStack {
                                Text("Reply")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.footnote)
                                    .foregroundStyle(.accent)
                                    .onTapGesture {
                                        onReplyTapped?()
                                    }
                                if comment.canDelete == 1 {
                                    Text("Delete")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                        .onTapGesture {
                                            Responses.shared.deleteComment(
                                                token: token,
                                                commentedType: commentedType,
                                                userId: nil,
                                                commentId: comment.id
                                            ) { result in
                                                switch result {
                                                case .success(let wasDeleted):
                                                    if wasDeleted {
                                                        isDeleted = true
                                                    }
                                                case .failure(let error):
                                                    print("Something went wrong: \(error.localizedDescription)")
                                                }
                                            }
                                        }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.leading, 5)
                    VStack {
                        Image(systemName: comment.likes.userLikes == 1 ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(comment.likes.userLikes == 1 ? .red : .gray)
                            .padding(.top, 10)
                            .onTapGesture {
                                var isAlreadyLiked = false
                                
                                if comment.likes.userLikes == 1 {
                                    isAlreadyLiked = true
                                    comment.likes.userLikes = 0
                                } else {
                                    comment.likes.userLikes = 1
                                }
                                
                                Responses.shared.like(isAlreadyLiked: isAlreadyLiked, token: token, type: objectType, itemId: comment.id, userId: comment.fromId, accessKey: nil) { result in
                                    switch result {
                                    case .success(let likes):
                                        comment.likes.count = likes
                                    case .failure(let error):
                                        print("Comment with id \(comment.id) is NOT \(isAlreadyLiked ? "dis": "")liked because of an Error: \(error.localizedDescription)")
                                    }
                                }
                            }
                        Text(String(comment.likes.count))
                            .font(.footnote)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    CommentsRow(token: InfoPlist.tokenForPreviews, objectType: .photoComment, commentedType: .video, comment: Comment(id: 540, fromId: 220458, date: 1702932684, text: "Проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка проверка", canEdit: 1, canDelete: 1, likes: CommentLikes(canLike: 1, count: 0, userLikes: 0)), canComment: true, profile: CommentProfile(id: 220458, photo: "https://sun1-91.userapi.com/s/v1/ig2/Cx8BNM9-QV-B_zA4TV6nzRDr2Yx4zOv5OhU4-5t14shC0Z8mVrosq88vnZxss5bfvhbEOTEslmlpN1Y25tIOBrA5.jpg?size=50x50&quality=95&crop=234,83,658,658&ava=1", firstName: "Андрей", lastName: "Мацуленко"))
}
