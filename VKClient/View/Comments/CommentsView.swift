//
//  CommentsView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

struct CommentsView: View {
    
    @State var comments: [Comment]
    @State var newCommentText: String = ""
    @State var replyTo: Comment?
    @State var profile = Mocks.shared.profile
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(comments) { comment in
                        CommentsRow(comment: comment) {
                            replyTo = comment
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.top, 16)
                Divider()
                if replyTo != nil {
                    HStack {
                        replyTo!.authorAvatar
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 25, height: 25)
                            .shadow(radius: 5)
                            .clipped()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        Text(replyTo!.authorName + " wrote: \"" + replyTo!.text + "\"")
                            .lineLimit(1)
                            .font(.footnote)
                            .foregroundStyle(Color.accentColor)
                        Spacer()
                        Image(systemName: "xmark")
                            .onTapGesture {
                                replyTo = nil
                            }
                    }
                }
                TextField(replyTo == nil ? "Add new comment" : "Your reply", text: $newCommentText, axis: .vertical)
                    .lineLimit(1...5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 35))
            }
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
        .padding(.horizontal, 16)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
    
    private func submitComment() {
        if newCommentText != "" {
            let name = profile.name + " " + profile.surname
            let newComment = Comment(
                id: Int.random(in: 1000...9999),
                authorName: name,
                authorAvatar: profile.avatar ?? Image("VKClient"),
                text: newCommentText,
                likes: 0,
                postDate: "1 hour ago", 
                liked: false,
                isReply: replyTo != nil ? true : false
            )
            comments.append(newComment)
            newCommentText = ""
            replyTo = nil
        }
    }
}

#Preview {
    CommentsView(comments: Mocks.shared.comments)
}
