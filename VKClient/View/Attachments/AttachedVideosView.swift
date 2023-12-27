//
//  AttachedVideosView.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct AttachedVideosView: View {
    
    @State var token: String
    @State var videos: [VideoAttachment]
    @State var selectedVideo: SelectedVideo?
    
    var body: some View {
        VStack {
            ForEach(videos.indices, id: \.self) { index in
                let imageUrl: String = {
                    if videos[index].image?.count ?? 0 > 1 {
                        return videos[index].image![1].url
                    } else {
                        return "https://vk.com/images/video/thumbs/video_m.png"
                    }
                }()
                
                let durationText: String = {
                    if videos[index].duration != nil {
                        return videos[index].duration!.secondsToHoursMinutesSeconds
                    } else {
                        return ""
                    }
                }()
                
                HStack {
                    VStack {
                        HStack {
                            Color.clear
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 90)
                                .overlay(
                                    AsyncImage(url: URL(string: imageUrl)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                ).clipped()
                                .clipShape(.rect(cornerRadius: 15))
                                .overlay(
                                    Text(durationText)
                                        .background(Color.black.opacity(0.6))
                                        .foregroundStyle(.white)
                                        .font(.subheadline)
                                        .padding(10),
                                    alignment: .bottomTrailing
                                )
                                .overlay(
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .shadow(radius: 5)
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                )
                                .onTapGesture {
                                    loadVideo(videoId: videos[index].id, ownerId: videos[index].ownerId)
                                }
                                .shadow(radius: 5)
                            Spacer()
                        }
                        HStack {
                            Text(videos[index].title)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .frame(width: 160, alignment: .leading)
                                .foregroundStyle(Color.accentColor)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .onTapGesture {
                                    loadVideo(videoId: videos[index].id, ownerId: videos[index].ownerId)
                                }
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
        .fullScreenCover(item: $selectedVideo) { selectedVideo in
            VideoView(token: token, withXmark: true, video: selectedVideo.video, authorName: selectedVideo.selectedVideoAuthorName, authorAvatarUrl: selectedVideo.selectedVideoAuthorAvatar)
        }
    }
    
    private func loadVideo(videoId: Int, ownerId: Int) {
        Responses.shared.getVideo(token: token, userId: ownerId, video: videoId, albumId: nil, offset: nil, count: 1) { result in
            switch result {
            case .success(let videoResult):
                let selectedVideoAuthorName: String = {
                    if videoResult.items.first?.ownerId ?? 0 > 0 {
                        let firstName = videoResult.profiles!.first!.firstName
                        let lastName = videoResult.profiles!.first!.lastName
                        return firstName + " " + lastName
                    } else {
                        return videoResult.groups!.first!.name
                    }
                }()
                
                let selectedVideoAuthorAvatar: String = {
                    if videoResult.items.first?.ownerId ?? 0 > 0 {
                        return videoResult.profiles!.first!.photo
                    } else {
                        return videoResult.groups!.first!.photo
                    }
                }()
                
                let video = videoResult.items.first!
                
                self.selectedVideo = SelectedVideo(
                    id: video.id,
                    selectedVideoAuthorName: selectedVideoAuthorName,
                    selectedVideoAuthorAvatar: selectedVideoAuthorAvatar,
                    video: video
                )
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}

struct SelectedVideo: Identifiable {
    var id: Int
    var selectedVideoAuthorName: String
    var selectedVideoAuthorAvatar: String
    var video: Video
}

#Preview {
    AttachedVideosView(token: InfoPlist.tokenForPreviews,
                       videos: [
                        VideoAttachment(accessKey: "e389f42841d4205cc9", duration: 1021, image: [VideoAttachmentImage(url: "https://sun1-30.userapi.com/c858228/v858228107/a6ce/P5UOO__B-zE.jpg"), VideoAttachmentImage(url: "https://sun1-30.userapi.com/c858228/v858228107/a6ce/P5UOO__B-zE.jpg")], id: 456239444, ownerId: -48677005, title: "Мы улучшили расписание электричек Туту.ру. Что изменилось?", type: "video"),
                        VideoAttachment(accessKey: "9f99e1ac2304b0200c", duration: 1021, image: [VideoAttachmentImage(url: "https://sun1-30.userapi.com/c858228/v858228107/a6ce/P5UOO__B-zE.jpg"), VideoAttachmentImage(url: "https://sun1-30.userapi.com/c858228/v858228107/a6ce/P5UOO__B-zE.jpg")], id: 456239017, ownerId: 711471713, title: "Выписка Алисы из роддома", type: "video")
                       ])
}

