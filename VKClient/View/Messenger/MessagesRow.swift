//
//  MessagesRow.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct MessagesRow: View {
    @State var message: Message
    @State var selectedPhoto: Photo?
    @State var selectedVideo: Video?
    
    var body: some View {
        
        let avatar: Image = {
            if message.profile.avatar != nil {
                return message.profile.avatar!
            } else {
                return Image("VKClient")
            }
        }()
        
        HStack {
            VStack {
                Spacer()
                if message.isMyMessage == false {
                    NavigationLink {
                        ProfileView(profile: message.profile, isMyProfile: false)
                    } label: {
                        avatar
                            .resizable()
                            .scaledToFill()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 20, height: 20)
                            .shadow(radius: 5)
                            .padding(.trailing, 8)
                    }
                }
            }
            
            ZStack {
                if message.isMyMessage {
                    Color.accentColor
                        .clipShape(.rect(cornerRadius: 20))
                        .opacity(0.3)
                } else {
                    Color.gray
                        .clipShape(.rect(cornerRadius: 20))
                        .opacity(0.3)
                }
                VStack {
                    HStack {
                        Text(message.text)
                            .font(.footnote)
                        Spacer()
                    }
                    if message.attachedPhotos != nil {
                        AttachedPhotosView(photos: message.attachedPhotos!)
                    }
                    
                    if message.attachedVideos != nil {
                        AttachedVideosView(videos: message.attachedVideos!)
                    }
                }
                .padding(25)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(message.postDate)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 16))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: message.isMyMessage ? 66 : 16, bottom: 5, trailing: message.isMyMessage ? 16 : 56))
    }
}

#Preview {
    MessagesRow(message: Mocks.shared.messageWithPhoto)
}
