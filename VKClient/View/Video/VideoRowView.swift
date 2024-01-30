//
//  VideoRowView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct VideoRowView: View {
    var token: String
    var video: Video
    var authorAvatarUrl: String?
    var authorName: String?
    
    var body: some View {
        let durationText: String = {
            if video.type == "live" {
                return "LIVE"
            } else {
                if video.duration == nil {
                    return ""
                } else {
                    return video.duration!.secondsToHoursMinutesSeconds
                }
            }
        }()
        
        VStack {
            NavigationLink {
                VideoView(
                    token: token,
                    video: video,
                    authorName: authorName ?? "",
                    authorAvatarUrl: authorAvatarUrl ?? ""
                )
            } label: {
                VStack {
                    Color.clear
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                            .overlay(
                                AsyncImage(url: URL(string: video.image.last!.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .shadow(radius: 5)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                            ).clipped()
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(
                            Text(durationText)
                                .background(durationText == "LIVE" ? Color.red : Color.black.opacity(0.6))
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .padding(10),
                            alignment: .bottomTrailing
                        )
                        .overlay(
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .shadow(radius: 5)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                        )
                        .shadow(radius: 5)
                }
                Spacer()
            }
            HStack {
                NavigationLink {
                    ProfileView(token: token, userId: video.ownerId)
                } label: {
                    AsyncImage(url: URL(string: authorAvatarUrl ?? "https://vk.com/images/camera_50.png")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 5)
                            .padding(.trailing, 10)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack {
                    HStack {
                        NavigationLink {
                            VideoView(
                                token: token,
                                video: video,
                                authorName: authorName ?? "",
                                authorAvatarUrl: authorAvatarUrl ?? ""
                            )
                        } label: {
                            Text(video.title)
                                .font(.headline)
                                .foregroundStyle(.text)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    HStack {
                        Text(videoHeaders())
                            .font(.footnote)
                            .foregroundStyle(.primary)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            .padding(.top, 10)
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
        
        let videoViews = String(format: NSLocalizedString("views", comment: ""), video.views) + " • "
        
        let date: String = {
            if video.addingDate != nil {
                Date(unixTime: video.addingDate!).longDateWithTime
            } else if video.date != nil {
                Date(unixTime: video.date!).longDateWithTime
            } else {
                ""
            }
        }()
        
        return (name + videoViews + date)
    }
}

#Preview {
    VideoRowView(
        token: InfoPlist.tokenForPreviews,
        video:
                Video(addingDate: 1700730269,
                      canComment: 1,
                      comments: 10,
                      duration: 1160,
                      id: 160163042,
                      image: [VideoImage(url: "https://i.mycdn.me/getVideoPreview?id=5708275452458&idx=12&type=39&tkn=_6cyUxpNHQ_vKtiKPnWkHxgHpug&fn=vid_m"), VideoImage(url: "https://i.mycdn.me/getVideoPreview?id=5708275452458&idx=12&type=39&tkn=_6cyUxpNHQ_vKtiKPnWkHxgHpug&fn=vid_u")],
                      ownerId: 220458,
                      title: "Алина. Посвящение в первоклассники",
                      player: "https://vk.com/video_ext.php?oid=220458&id=456239122&hash=56c308d82a78dbe7&__ref=vk.api&api_hash=170326647237e68a90748cabe399_GIZDANBVHA",
                      added: 1,
                      type: "video",
                      views: 100,
                      likes: VideoLikes(count: 10, userLikes: 1),
                      reposts: VideoReposts(count: 2)))
}
