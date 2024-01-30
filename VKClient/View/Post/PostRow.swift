//
//  PostRow.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftData
import SwiftUI

struct PostRow: View {
    @Environment(\.modelContext) var modelContext
    @Query var storedPosts: [WallpostModel]
    
    @State var hasError = false
    var token: String
    @State var post: Wallpost?
    var name: String
    var avatarUrl: String
    @State var isDeleted: Bool = false
    @State private var showingComments = false
    @State var isSaved = false
    var repostName: String?
    var repostAvatarUrl: String?
    
    var body: some View {
        
        if hasError {
            HStack {
                Text("Something went wrong")
            }
            .padding(16)
        } else if isDeleted {
            HStack {
                Text("This post was deleted")
            }
            .padding(16)
        } else {
            VStack {
                if post != nil {
                    HStack {
                        NavigationLink {
                            ProfileView(token: token, userId: post!.fromId ?? post!.sourceId)
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
                        VStack {
                            HStack {
                                NavigationLink {
                                    ProfileView(token: token, userId: post!.fromId ?? post!.sourceId)
                                } label: {
                                    Text(name)
                                        .fontWeight(.bold)
                                        .font(.footnote)
                                        .foregroundStyle(.text)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            HStack {
                                Text(Date(unixTime: post!.date).longDateWithTime)
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                                Spacer()
                            }
                        }
                    }
                    HStack {
                        Text(post!.text)
                            .font(.footnote)
                        Spacer()
                    }
                    if let attachments = post!.attachments {
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
                    if let originals = post!.copyHistory {
                        if let original = originals.first {
                            VStack {
                                HStack {
                                    NavigationLink {
                                        ProfileView(token: token, userId: original.fromId)
                                    } label: {
                                        AsyncImage(url: URL(string: repostAvatarUrl ?? "https://vk.com/images/camera_50.png")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                                .frame(width: 40, height: 40)
                                                .shadow(radius: 5)
                                                .padding(.trailing, 10)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    VStack {
                                        HStack {
                                            NavigationLink {
                                                ProfileView(token: token, userId: original.fromId)
                                            } label: {
                                                Text(repostName ?? name)
                                                    .fontWeight(.bold)
                                                    .font(.footnote)
                                                    .foregroundStyle(.text)
                                                    .lineLimit(nil)
                                                    .multilineTextAlignment(.leading)
                                            }
                                            Spacer()
                                        }
                                        HStack {
                                            Text(Date(unixTime: original.date).longDateWithTime)
                                                .foregroundStyle(.secondary)
                                                .font(.footnote)
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                                VStack {
                                    HStack {
                                        Text(original.text)
                                            .font(.footnote)
                                        Spacer()
                                    }
                                    if let attachments = original.attachments {
                                        VStack {
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
                                    }
                                }
                                .padding(16)
                            }
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.leading, 16)
                        }
                    }
                    
                    HStack {
                        HStack {
                            Image(systemName: post!.likes.userLikes == 1 ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(post!.likes.userLikes == 1 ? .red : .gray)
                                .onTapGesture {
                                    var isAlreadyLiked = false
                                    
                                    if post!.likes.userLikes == 1 {
                                        isAlreadyLiked = true
                                        post!.likes.userLikes = 0
                                    } else {
                                        post!.likes.userLikes = 1
                                    }
                                    
                                    Responses.shared.like(isAlreadyLiked: isAlreadyLiked, token: token, type: .post, itemId: post!.id, userId: post!.fromId, accessKey: nil) { result in
                                        switch result {
                                        case .success(let likes):
                                            post!.likes.count = likes
                                        case .failure(let error):
                                            print("Comment with id \(post!.id) is NOT \(isAlreadyLiked ? "dis": "")liked because of an Error: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            Text(String(post!.likes.count))
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "message.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray)
                            Text(String(post!.comments.count))
                                .foregroundStyle(.gray)
                        }
                        .onTapGesture {
                            showingComments = true
                        }
                        Spacer()
                        HStack {
                            let repostImageName: String = {
                                if post!.reposts.userReposted == 1 {
                                    return "arrowshape.turn.up.left.fill"
                                } else {
                                    return "arrowshape.turn.up.left"
                                }
                            }()
                            
                            Image(systemName: repostImageName)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray)
                            Text(String(post!.reposts.count))
                                .foregroundStyle(.gray)
                        }
                        .onTapGesture {
                            if post!.reposts.userReposted != 1 && post!.canDelete != 1 {
                                Responses.shared.repost(
                                    token: token,
                                    ownerId: post!.ownerId,
                                    postId: post!.id
                                ) { result in
                                    switch result {
                                    case .success(let repostCount):
                                        post!.reposts.count = repostCount
                                        post!.reposts.userReposted = 1
                                    case .failure(let error):
                                        print("Something went wrong: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                        Spacer()
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 15, height: 20)
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                if isSaved {
                                    isSaved = false
                                    deletePost()
                                } else {
                                    isSaved = true
                                    savePost()
                                }
                            }
                    }
                    
                    if post!.canDelete == 1 {
                        HStack {
                            Text("Delete")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.footnote)
                                .foregroundStyle(.red)
                                .onTapGesture {
                                    Responses.shared.deletePost(
                                        token: token,
                                        userId: nil,
                                        postId: post!.id
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
                            Spacer()
                        }
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: 700)
            .sheet(isPresented: $showingComments) {
                NavigationStack {
                    let canComment: Bool = {
                        if post!.comments.canPost == 1 {
                            return true
                        } else {
                            return false
                        }
                    }()
                    CommentsView(token: token, commentedType: .post, objectId: post!.id, canComment: canComment, userId: post!.ownerId)
                    
                }
            }
            .onAppear {
                isSaved = fetchPost()
            }
        }
    }
    
    private func savePost() {
        guard let post else { return }
        var attachments: [LinkAttachmentModel] = []
        var historyElements: [WallHistoryModel] = []
        
        if let sourceAttachments = post.attachments {
            if let attachedLinks = Attachments.shared.attachedLinks(attachments: sourceAttachments) {
                for attachedLink in attachedLinks {
                    let attachment = LinkAttachmentModel(url: attachedLink.url, caption: attachedLink.caption, descriptionText: attachedLink.description, title: attachedLink.title)
                    attachments.append(attachment)
                }
            }
        }
        
        if let sourceHistoryElements = post.copyHistory {
            for sourceHistory in sourceHistoryElements {
                var historyAttachments: [LinkAttachmentModel] = []
                
                if let sourceHistoryAttachments = sourceHistory.attachments {
                    if let historyAttachedLinks = Attachments.shared.attachedLinks(attachments: sourceHistoryAttachments) {
                        for historyAttachedLink in historyAttachedLinks {
                            let attachment = LinkAttachmentModel(url: historyAttachedLink.url, caption: historyAttachedLink.caption, descriptionText: historyAttachedLink.description, title: historyAttachedLink.title)
                            historyAttachments.append(attachment)
                        }
                    }
                }
                
                let historyElement = WallHistoryModel(type: sourceHistory.type, linkAttachments: historyAttachments, date: sourceHistory.date, fromId: sourceHistory.fromId, fromName: repostName ?? name, id: sourceHistory.id, ownerId: sourceHistory.ownerId, text: sourceHistory.text)
                historyElements.append(historyElement)
            }
        }
        
        let postToSave = WallpostModel(copyHistory: historyElements, linkAttachments: attachments, date: post.date, fromId: post.fromId ?? post.sourceId ?? post.ownerId, fromName: name, id: post.id, ownerId: post.ownerId, text: post.text, saveDate: .now)
        
        modelContext.insert(postToSave)
    }
    
    private func deletePost() {
        guard let post else { return }
        
        guard let itemToDelete = storedPosts.first(where: { $0.id == post.id }) else { return }
        
        modelContext.delete(itemToDelete)
    }
    
    private func fetchPost() -> Bool {
        guard let post else { return false }
        
        for storedPost in storedPosts {
            if storedPost.id == post.id {

                return true
            }
        }
        
        return false
    }
}

#Preview {
    PostRow(token: InfoPlist.tokenForPreviews, post: WallMock.shared.wallposts.items[0], name: WallMock.shared.wallposts.groups!.first!.name, avatarUrl: WallMock.shared.wallposts.groups!.first!.photo)
        .modelContainer(for: WallpostModel.self)
}
