//
//  VideoView.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var token: String
    @State var hasError = false
    @Environment(\.dismiss) var dismiss
    @State var withXmark: Bool?
    @State var video: Video
    @State var authorName: String?
    @State var authorAvatarUrl: String?
    @State var statusChanged = false
    
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
                if hasError {
                    Text("Something went wrong")
                } else {
                    VideoPlayer(url: video.player ?? "")
                        .frame(height: 250, alignment: .center)
                        .clipped()
                        .shadow(radius: 10)
                    
                    HStack {
                        AsyncImage(url: URL(string: authorAvatarUrl ?? "https://vk.com/images/camera_50.png")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .shadow(radius: 5)
                                .padding(.horizontal, 10)
                        } placeholder: {
                            ProgressView()
                        }
                                                    
                        VStack(spacing: 0) {
                            HStack {
                                Text(video.title)
                                    .font(.headline)
                                Spacer()
                            }
                            HStack {
                                Text(videoHeaders())
                                    .font(.footnote)
                                Spacer()
                            }
                            if video.canAdd == 1 {
                                HStack {
                                    let isAddedBefore: Bool = {
                                        if video.added == 1 {
                                            true
                                        } else {
                                            false
                                        }
                                    }()
                                    
                                    let imageName: String = {
                                        if statusChanged {
                                            "checkmark"
                                        } else if video.added == 1 {
                                            "xmark"
                                        } else {
                                            "plus"
                                        }
                                    }()
                                    
                                    let addVideoText: String = {
                                        if statusChanged {
                                            if video.added == 1 {
                                                "Deleted from my videos"
                                            } else {
                                                "Added to my videos"
                                            }
                                        } else if video.added == 1 {
                                            "Delete from my videos"
                                        } else {
                                            "Add to my videos"
                                        }
                                    }()
                                    
                                    let addVideoColor: Color = {
                                        if statusChanged {
                                            .green
                                        } else if video.added == 1 {
                                            .red
                                        } else {
                                            Color.accentColor
                                        }
                                    }()
                                    
                                    HStack {
                                        Image(systemName: imageName)
                                            .foregroundStyle(addVideoColor)
                                        Text(addVideoText)
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(addVideoColor)
                                    }
                                    .onTapGesture {
                                        Responses.shared.addOrDeleteVideo(
                                            token: token,
                                            videoId: video.id,
                                            userId: video.ownerId,
                                            isAddedBefore: isAddedBefore
                                        ) { result in
                                            switch result {
                                            case .success(let wasAddedOrDeleted):
                                                if wasAddedOrDeleted {
                                                    statusChanged.toggle()
                                                }
                                            case .failure(let error):
                                                print("Something went wrong: \(error.localizedDescription)")
                                            }
                                        }
                                    }
                                    Spacer()
                                    
                                }
                                .padding(.top, 5)
                            }
                        }
                        if video.likes != nil {
                            VStack {
                                Image(systemName: video.likes!.userLikes == 1 ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(video.likes!.userLikes == 1 ? .red : .gray)
                                    .onTapGesture {
                                        var isAlreadyLiked = false
                                        
                                        if video.likes!.userLikes == 1 {
                                            video.likes!.userLikes = 0
                                            isAlreadyLiked = true
                                        } else if video.likes!.userLikes == 0 {
                                            video.likes!.userLikes = 1
                                        }
                                        
                                        Responses.shared.like(isAlreadyLiked: isAlreadyLiked, token: token, type: .video, itemId: video.id, userId: video.ownerId, accessKey: nil) { result in
                                            switch result {
                                            case .success(let likes):
                                                video.likes!.count = likes
                                            case .failure(let error):
                                                print("Photo with id \(video.id) is NOT \(isAlreadyLiked ? "dis": "")liked because of an Error: \(error.localizedDescription)")
                                                hasError = true
                                            }
                                        }
                                    }
                                Text(String(video.likes!.count))
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.top, 10)
                    
                    HStack {
                        Text(video.description ?? "")
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(10)
                    
                    CommentsView(token: token, commentedType: .video, objectId: video.id, canComment: (video.canComment != 0), userId: video.ownerId)
                    Spacer()
                }
            }
        }
    }
    
    private func videoHeaders() -> String {
        let name: String = {
            if authorName != nil {
                return (authorName! + " • ")
            } else {
                return ""
            }
        }()
        
        let videoViews = String(video.views) + " " + "views"
                
        let date: String = {
            if video.addingDate != nil {
                " • " + Date(unixTime: video.addingDate!).longDateWithTime
            } else if video.date != nil {
                " • " + Date(unixTime: video.date!).longDateWithTime
            } else {
                ""
            }
        }()
        
        return (name + videoViews + date)
    }
}

#Preview {
    VideoView(
        token: InfoPlist.tokenForPreviews,
        video:
                Video(addingDate: 1700730269,
                      canComment: 1,
                      canAdd: 1,
                      comments: 10,
                      duration: 1160,
                      id: 143094486,
                      image: [VideoImage(url: "https://i.mycdn.me/getVideoPreview?id=5708275452458&idx=12&type=39&tkn=_6cyUxpNHQ_vKtiKPnWkHxgHpug&fn=vid_m"), VideoImage(url: "https://i.mycdn.me/getVideoPreview?id=5708275452458&idx=12&type=39&tkn=_6cyUxpNHQ_vKtiKPnWkHxgHpug&fn=vid_m")],
                      ownerId: 220458,
                      title: "Алина. Посвящение в первоклассники",
                      player: "https://vk.com/video_ext.php?oid=220458&id=456239122&hash=56c308d82a78dbe7&__ref=vk.api&api_hash=170326647237e68a90748cabe399_GIZDANBVHA",
                      added: 1, 
                      type: "video",
                      views: 100,
                      likes: VideoLikes(count: 10, userLikes: 1),
                      reposts: VideoReposts(count: 2)))
}
