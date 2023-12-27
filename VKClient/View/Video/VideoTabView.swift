//
//  VideoTabView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct VideoTabView: View {
    
    @State var hasError = false
    var token: String
    var userId: Int?
    var albumId: Int?
    let limit = 10
    @State var videosLoaded: Int = 0
    var isSearch = false
    var query: String?
    @State var videos: Videos?
    
    var body: some View {
        if hasError {
            Text("Something went wrong")
        } else {
            VStack {
                if videos != nil {
                    if videos!.count > 0 {
                        ForEach(videos!.items, id: \.self) { video in
                            if video.contentRestricted != 1 {
                                VideoRowView(token: token, video: video, authorAvatarUrl: getAvatar(id: video.ownerId), authorName: getName(id: video.ownerId))
                                    .padding(EdgeInsets(top: 5, leading: 16, bottom: 11, trailing: 10))
                                Divider()
                            }
                        }
                        if videosLoaded < videos!.count {
                            Button(
                                action: {
                                    loadMore()
                                }, label: {
                                    Text("Load more")
                                })
                            .buttonStyle(DefaultButton())
                            .padding(.horizontal, 26)
                            .padding(.bottom, 10)
                        }
                    } else {
                        Text("There are no videos")
                    }
                }
            }
            .onAppear {
                if videosLoaded == 0 {
                    if isSearch {
                        guard let query else { return }
                        Responses.shared.searchVideo(token: token, q: query, offset: 0, count: limit) { result in
                            switch result {
                            case .success(let videos):
                                self.videos = videos
                                videosLoaded += limit
                            case .failure(let error):
                                print("Something went wrong: \(error.localizedDescription)")
                                hasError = true
                            }
                        }
                    } else {
                        Responses.shared.getVideo(token: token, userId: userId, video: nil, albumId: albumId, offset: 0, count: limit) { result in
                            switch result {
                            case .success(let videos):
                                self.videos = videos
                                videosLoaded += limit
                            case .failure(let error):
                                print("Something went wrong: \(error.localizedDescription)")
                                hasError = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getName(id: Int) -> String? {
        if id >= 0 {
            let firstName = videos?.profiles?.first(where: { $0.id == id })?.firstName ?? ""
            let lastName = videos?.profiles?.first(where: { $0.id == id })?.lastName ?? ""
            let name = firstName + " " + lastName
            
            return name
        } else {
            let groupId = id * (-1)
            return videos?.groups?.first(where: { $0.id == groupId })?.name
        }
    }
    
    private func getAvatar(id: Int) -> String? {
        if id >= 0 {
            return videos?.profiles?.first(where: { $0.id == id })?.photo
        } else {
            let groupId = id * (-1)
            return videos?.groups?.first(where: { $0.id == groupId })?.photo
        }
    }
    
    private func loadMore() {
        if isSearch {
            guard let query else { return }
            Responses.shared.searchVideo(token: token, q: query, offset: videosLoaded, count: limit) { result in
                switch result {
                case .success(let moreVideos):
                    if self.videos != nil {
                        self.videos!.items.append(contentsOf: moreVideos.items)
                        
                        if moreVideos.profiles?.count ?? 0 > 0 {
                            if self.videos!.profiles == nil {
                                self.videos!.profiles = moreVideos.profiles
                            } else {
                                self.videos!.profiles?.append(contentsOf: moreVideos.profiles ?? [])
                            }
                        }
                        
                        if moreVideos.groups?.count ?? 0 > 0 {
                            if self.videos!.groups == nil {
                                self.videos!.groups = moreVideos.groups
                            } else {
                                self.videos!.groups?.append(contentsOf: moreVideos.groups ?? [])
                            }
                        }
                                            
                        videosLoaded += limit
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        } else {
            Responses.shared.getVideo(token: token, userId: userId, video: nil, albumId: albumId, offset: videosLoaded, count: limit) { result in
                switch result {
                case .success(let moreVideos):
                    if self.videos != nil {
                        self.videos!.items.append(contentsOf: moreVideos.items)
                        
                        if moreVideos.profiles?.count ?? 0 > 0 {
                            if self.videos!.profiles == nil {
                                self.videos!.profiles = moreVideos.profiles
                            } else {
                                self.videos!.profiles?.append(contentsOf: moreVideos.profiles ?? [])
                            }
                        }
                        
                        if moreVideos.groups?.count ?? 0 > 0 {
                            if self.videos!.groups == nil {
                                self.videos!.groups = moreVideos.groups
                            } else {
                                self.videos!.groups?.append(contentsOf: moreVideos.groups ?? [])
                            }
                        }
                        
                        videosLoaded += limit
                    }
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
}

#Preview {
    VideoTabView(token: InfoPlist.tokenForPreviews, isSearch: true, query: "cats")
}
