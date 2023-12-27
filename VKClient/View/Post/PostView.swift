//
//  PostView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

struct PostView: View {
    
    @Binding var createNewPost: Bool
    @State var posts: Wallposts?
    @State var hasError = false
    var token: String
    var userId: Int?
    let limit: Int = 5
    @State var postsLoaded: Int = 0
    var isFeed = false
    @State var nextFrom: String?
    
    var body: some View {
        if hasError {
            Text("Something went wrong")
        } else {
            VStack {
                if posts != nil {
                    ForEach(posts!.items, id: \.self) { post in
                        
                        
                        let repostName: String? = {
                            if post.copyHistory != nil {
                                return getName(id: post.copyHistory!.first!.fromId ?? post.copyHistory!.first!.ownerId)
                            } else {
                                return nil
                            }
                        }()
                        
                        let repostAvatarUrl: String? = {
                            if post.copyHistory != nil {
                                return getAvatar(id: post.copyHistory!.first!.fromId ?? post.copyHistory!.first!.ownerId)
                            } else {
                                return nil
                            }
                        }()
                        
                        HStack {
                            PostRow(token: token, post: post, name: getName(id: post.fromId ?? post.sourceId ?? post.ownerId) ?? "", avatarUrl: getAvatar(id: post.fromId ?? post.sourceId ?? post.ownerId) ?? "https://vk.com/images/camera_50.png", repostName: repostName, repostAvatarUrl: repostAvatarUrl)
                            Spacer()
                        }
                        Divider()
                    }
                    if postsLoaded < posts!.count ?? 1000 {
                        Button(
                            action: {
                                loadMorePosts()
                            }, label: {
                                Text("Load more")
                            })
                        .buttonStyle(DefaultButton())
                        .padding(.horizontal, 26)
                    }
                }
            }
            .onAppear {
                if postsLoaded == 0 {
                    loadPosts()
                }
            }
            .sheet(isPresented: $createNewPost,
                   onDismiss: {
                loadPosts()
            }, content: {
                CreatePostView(token: token)
                    .presentationDetents([.medium])
            })
        }
    }
    
    private func getName(id: Int) -> String? {
        if id >= 0 {
            let firstName = posts?.profiles?.first(where: { $0.id == id })?.firstName ?? ""
            let lastName = posts?.profiles?.first(where: { $0.id == id })?.lastName ?? ""
            let name = firstName + " " + lastName
            
            return name
        } else {
            let groupId = id * (-1)
            return posts?.groups?.first(where: { $0.id == groupId })?.name
        }
    }
    
    private func getAvatar(id: Int) -> String? {
        if id >= 0 {
            return posts?.profiles?.first(where: { $0.id == id })?.photo
        } else {
            let groupId = id * (-1)
            return posts?.groups?.first(where: { $0.id == groupId })?.photo
        }
    }
    
    private func loadPosts() {
        if isFeed {
            Responses.shared.getFeed(
                token: token,
                startFrom: nil,
                count: limit
            ) { result in
                switch result {
                case .success(let wallposts):
                    self.posts = wallposts
                    self.postsLoaded = limit
                    self.nextFrom = wallposts.nextFrom
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        } else {
            Responses.shared.getWall(
                token: token,
                userId: userId,
                offset: nil,
                count: limit
            ) { result in
                switch result {
                case .success(let wallposts):
                    self.posts = wallposts
                    self.postsLoaded = limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
    
    private func loadMorePosts() {
        if isFeed {
            Responses.shared.getFeed(
                token: token,
                startFrom: nextFrom,
                count: limit
            ) { result in
                switch result {
                case .success(let morePosts):
                    self.posts!.items.append(contentsOf: morePosts.items)
                    self.posts!.groups?.append(contentsOf: morePosts.groups ?? [])
                    self.posts!.profiles?.append(contentsOf: morePosts.profiles ?? [])
                    self.nextFrom = morePosts.nextFrom
                    
                    if morePosts.profiles?.count ?? 0 > 0 {
                        if self.posts!.profiles == nil {
                            self.posts!.profiles = morePosts.profiles
                        } else {
                            self.posts!.profiles?.append(contentsOf: morePosts.profiles ?? [])
                        }
                    }
                    
                    if morePosts.groups?.count ?? 0 > 0 {
                        if self.posts!.groups == nil {
                            self.posts!.groups = morePosts.groups
                        } else {
                            self.posts!.groups?.append(contentsOf: morePosts.groups ?? [])
                        }
                    }
                    
                    postsLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        } else {
            Responses.shared.getWall(
                token: token,
                userId: userId,
                offset: postsLoaded,
                count: limit
            ) { result in
                switch result {
                case .success(let morePosts):
                    self.posts!.items.append(contentsOf: morePosts.items)
                    self.posts!.groups?.append(contentsOf: morePosts.groups ?? [])
                    self.posts!.profiles?.append(contentsOf: morePosts.profiles ?? [])
                    
                    
                    if morePosts.profiles?.count ?? 0 > 0 {
                        if self.posts!.profiles == nil {
                            self.posts!.profiles = morePosts.profiles
                        } else {
                            self.posts!.profiles?.append(contentsOf: morePosts.profiles ?? [])
                        }
                    }
                    
                    if morePosts.groups?.count ?? 0 > 0 {
                        if self.posts!.groups == nil {
                            self.posts!.groups = morePosts.groups
                        } else {
                            self.posts!.groups?.append(contentsOf: morePosts.groups ?? [])
                        }
                    }
                    
                    postsLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    PostView(createNewPost: .constant(false), token: InfoPlist.tokenForPreviews)
        .modelContainer(for: WallpostModel.self)
}
