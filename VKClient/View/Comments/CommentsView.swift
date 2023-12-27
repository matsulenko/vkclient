//
//  CommentsView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

struct CommentsView: View {
    @State var hasError = false
    @Environment(\.dismiss) var dismiss
    var token: String
    var commentedType: ObjectType
    var objectId: Int
    var canComment: Bool
    var userId: Int
    @State var comments: Comments?
    @State var newCommentText: String = ""
    @State var replyTo: Comment?
    @State var submittedCommentText: String = ""
    let commentsCount: Int = 10
    @State var commentsLoaded: Int = 0
    @State var lastLoadedCommentId: Int?
    
    var body: some View {
        if hasError {
            ZStack {
                Text("Something went wrong")
                if commentedType != .video {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                                .padding(10)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                        .padding(.top, 10)
                        Spacer()
                    }
                }
            }
        } else {
            ZStack {
                VStack {
                    VStack {
                        Text("Comments")
                            .font(.headline)
                            .padding(.top, 20)
                            .foregroundStyle(.text)
                    }
                    ScrollView {
                        if comments != nil {
                            if comments!.count == 0 {
                                Text("There are no comments")
                                    .padding(.top, 40)
                                    .font(.subheadline)
                                    .foregroundStyle(.text)
                            } else {
                                ForEach(comments!.items, id: \.self) { comment in
                                    let id = comment.fromId
                                    let commentType: ObjectType = {
                                        switch commentedType {
                                        case .post:
                                                .comment
                                        case .photo:
                                                .photoComment
                                        case .video:
                                                .videoComment
                                        default:
                                                .comment
                                        }
                                    }()
                                    CommentsRow(token: token, objectType: commentType, commentedType: commentedType, comment: comment, canComment: canComment, profile: getProfile(id: id), group: getGroup(id: id)) {
                                        replyTo = comment
                                    }
                                    .padding(.vertical, 8)
                                }
                                if commentsLoaded < comments!.count {
                                    Button(
                                        action: {
                                            loadMoreComments()
                                        }, label: {
                                            Text("Load more")
                                        })
                                    .buttonStyle(DefaultButton())
                                    .padding(.horizontal, 26)
                                }
                            }
                        }
                    }
                    if canComment {
                        VStack {
                            Divider()
                            if replyTo != nil {
                                if let replyToAuthor = replyToAuthor(id: replyTo!.fromId) {
                                    HStack {
                                        AsyncImage(url: URL(string: replyToAuthor.avatar)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                                .frame(width: 25, height: 25)
                                                .shadow(radius: 5)
                                                .clipped()
                                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text(replyToAuthor.name)
                                            .lineLimit(1)
                                            .font(.footnote)
                                            .foregroundStyle(Color.accentColor)
                                        Spacer()
                                        Image(systemName: "xmark")
                                            .onTapGesture {
                                                replyTo = nil
                                            }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            TextField(replyTo == nil ? "Add new comment" : "Your reply", text: $newCommentText, axis: .vertical)
                                .lineLimit(1...5)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 35))
                        }
                    }
                }
                
                if canComment {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "arrowtriangle.right.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(newCommentText == "" ? Color.gray : Color.accentColor)
                                .padding(10)
                                .onTapGesture {
                                    submitComment()
                                }
                        }
                    }
                }
                
                if commentedType != .video {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.accent)
                                .padding(10)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                        .padding(.top, 10)
                        Spacer()
                    }
                }
            }
            .onAppear {
                getComments()
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
        }
    }
    
    func getProfile(id: Int) -> CommentProfile? {
        if id >= 0 {
            return comments!.profiles!.first(where: { $0.id == id })
        } else {
            return nil
        }
    }
    
    func getGroup(id: Int) -> CommentGroup? {
        if id < 0 {
            let groupId = id * (-1)
            return comments!.groups!.first(where: { $0.id == groupId })
        } else {
            return nil
        }
    }
    
    func replyToAuthor(id: Int) -> ReplyToAuthor? {
        var name: String?
        var avatar: String?
        
        if id < 0 {
            let groupId = id * (-1)
            if let group = comments!.groups!.first(where: { $0.id == groupId }) {
                name = group.name
                avatar = group.photo
            }
        } else {
            if let profile = comments!.profiles!.first(where: { $0.id == id }) {
                name = profile.firstName + " " + profile.lastName
                avatar = profile.photo
            }
        }
        
        guard let name, let avatar else { return nil }
        
        return ReplyToAuthor(name: name, avatar: avatar)
    }
    
    private func submitComment() {
        if newCommentText != "" && newCommentText != submittedCommentText {
            let guid = UUID().uuidString
            Responses.shared.createComment(
                token: token,
                commentedType: commentedType,
                userId: userId,
                objectId: objectId,
                message: newCommentText,
                replyToComment: replyTo?.id,
                guid: guid
            ) { result in
                switch result {
                case .success(let isPosted):
                    if isPosted {
                        submittedCommentText = newCommentText
                        getComments()
                        newCommentText = ""
                        replyTo = nil
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getComments() {
        Responses.shared.getComments(
            token: token,
            commentedType: commentedType,
            objectId: objectId,
            userId: userId,
            offset: nil,
            count: commentsCount,
            startCommentId: nil
        ) { result in
            switch result {
            case .success(let comments): 
                self.comments = comments
                commentsLoaded += commentsCount
                lastLoadedCommentId = comments.items.last?.id
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadMoreComments() {
        Responses.shared.getComments(
            token: token,
            commentedType: commentedType,
            objectId: objectId,
            userId: userId,
            offset: 1,
            count: commentsCount,
            startCommentId: lastLoadedCommentId
        ) { result in
            switch result {
            case .success(let moreComments):
                self.comments!.items.append(contentsOf: moreComments.items)
                self.comments!.groups?.append(contentsOf: moreComments.groups ?? [])
                self.comments!.profiles?.append(contentsOf: moreComments.profiles ?? [])
                
                
                if moreComments.profiles?.count ?? 0 > 0 {
                    if self.comments!.profiles == nil {
                        self.comments!.profiles = moreComments.profiles
                    } else {
                        self.comments!.profiles?.append(contentsOf: moreComments.profiles ?? [])
                    }
                }
                
                if moreComments.groups?.count ?? 0 > 0 {
                    if self.comments!.groups == nil {
                        self.comments!.groups = moreComments.groups
                    } else {
                        self.comments!.groups?.append(contentsOf: moreComments.groups ?? [])
                    }
                }
                
                commentsLoaded += commentsCount
                lastLoadedCommentId = moreComments.items.last?.id
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}

struct ReplyToAuthor {
    var name: String
    var avatar: String
}

#Preview {
    CommentsView(token: InfoPlist.tokenForPreviews, commentedType: .video, objectId: 143094486, canComment: true, userId: 220458)
}
