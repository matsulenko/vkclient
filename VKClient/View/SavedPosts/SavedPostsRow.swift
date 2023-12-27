//
//  SavedPostsRow.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import SwiftData
import SwiftUI

struct SavedPostsRow: View {
    var token: String
    @Environment(\.modelContext) var modelContext
//    @Query var storedPosts: [WallpostModel]
    var post: WallpostModel
    
    var body: some View {
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        NavigationLink {
                            ProfileView(token: token, userId: post.fromId)
                        } label: {
                            Text(post.fromName)
                                .fontWeight(.bold)
                                .foregroundStyle(.text)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    HStack {
                        Text(Date(unixTime: post.date).longDateWithTime)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            
            HStack {
                Text(post.text)
                    .font(.footnote)
                Spacer()
            }
            .padding(.bottom, 10)
            
            if post.linkAttachments.count > 0 {
                if let attachments = buildLinkAttachments(attachments: post.linkAttachments) {
                    VStack {
                        AttachedLinksView(token: token, links: attachments)
                    }
                }
            }
            
            if let original = post.copyHistory.first {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                NavigationLink {
                                    ProfileView(token: token, userId: original.fromId)
                                } label: {
                                    Text(original.fromName)
                                        .fontWeight(.bold)
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
                        if original.linkAttachments.count > 0 {
                            if let attachments = buildLinkAttachments(attachments: original.linkAttachments) {
                                VStack {
                                    AttachedLinksView(token: token, links: attachments)
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
            
            HStack {
                Text("Delete the post from saved")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .onTapGesture {
                        deletePost()
                    }
            }
        }
        .padding(16)
        .frame(maxWidth: 700)
    }
    
    private func buildLinkAttachments(attachments: [LinkAttachmentModel]) -> [LinkAttachment]? {
        var linkAttachments: [LinkAttachment] = []
        
        for attachment in attachments {
            let linkAttachment = LinkAttachment(url: attachment.url, caption: attachment.caption, description: attachment.descriptionText, photo: nil, title: attachment.title)
            linkAttachments.append(linkAttachment)
        }
        
        if linkAttachments.count == 0 {
            return nil
        } else {
            return linkAttachments
        }
    }
    
    private func deletePost() {
        modelContext.delete(post)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: WallpostModel.self, configurations: config)
        let example = WallpostModel(date: 1676766289, fromId: 220458, fromName: "Andrey Matsulenko", id: 3540, ownerId: 220458, text: "Здесь текст", saveDate: .now)
        return SavedPostsRow(token: "", post: example)
            .modelContainer(for: WallpostModel.self)
    } catch {
        fatalError("Failed to create model container.")
    }
}
