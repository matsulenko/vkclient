//
//  ProfileVideosView.swift
//  VKClient
//
//  Created by Matsulenko on 05.12.2023.
//

import SwiftUI

struct ProfileVideosView: View {
    
    var token: String
    var userId: Int?
    let limit = 5
    
    @State var videos: Videos?
    @State var selectedVideo: Video?
    @State var selectedAvatar: String?
    @State var selectedName: String?
    
    var body: some View {
        VStack {
            if videos != nil {
                if videos!.count > 0 {
                    NavigationLink {
                        VideoPlaylistView(token: token, userId: userId)
                    } label: {
                        VStack {
                            Divider()
                            HStack {
                                Text("Videos")
                                    .foregroundStyle(Color("Text"))
                                    .font(.headline)
                                Text(String(videos!.count))
                                    .foregroundStyle(.gray)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(videos!.items.prefix(limit).indices, id: \.self) { index in
                                let durationText: String = {
                                    if videos!.items[index].type == "live" {
                                        return "LIVE"
                                    }
                                    else {
                                        if let durationDouble = videos!.items[index].duration {
                                            return durationDouble.secondsToHoursMinutesSeconds
                                        } else {
                                            return ""
                                        }
                                    }
                                }()
                                
                                if videos!.items[index].contentRestricted != 1 {
                                    NavigationLink {
                                        VideoView(
                                            token: token,
                                            video: videos!.items[index],
                                            authorName: getName(id: videos!.items[index].ownerId),
                                            authorAvatarUrl: getAvatar(id: videos!.items[index].ownerId)
                                        )
                                    } label: {
                                        Color.clear
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 160, height: 90)
                                            .overlay(
                                                AsyncImage(url: URL(string: videos!.items[index].image[1].url)) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 160, height: 90)
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
                                                    .frame(width: 25, height: 25)
                                                    .shadow(radius: 5)
                                                    .foregroundStyle(.white)
                                                    .opacity(0.5)
                                            )
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            if videos!.count > limit {
                                NavigationLink {
                                    VideoPlaylistView(token: token, userId: userId)
                                } label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.additionalColor1, Color.additionalColor2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 160, height: 90)
                                        .overlay(
                                            Text("All videos")
                                                .font(.headline)
                                                .foregroundStyle(Color.white)
                                        )
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .onAppear {
            Responses.shared.getVideo(token: token, userId: userId, video: nil, albumId: nil, offset: 0, count: limit) { result in
                switch result {
                case .success(let videos): self.videos = videos
                case .failure(let error): print("Something went wrong: \(error.localizedDescription)")
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
    
}

#Preview {
    ProfileVideosView(
        token: InfoPlist.tokenForPreviews)
}
