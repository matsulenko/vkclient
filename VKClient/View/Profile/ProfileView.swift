//
//  ProfileView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var profile: Profile
    @State var posts: [Post] = Mocks.shared.posts
    @State var photos: [Photo] = Mocks.shared.photos
    @State var videos: [Video] = Mocks.shared.videos
    @State var isMyProfile = true
    @State private var barHidden = false
    
    var body: some View {
        
        let name: String = profile.name + " " + profile.surname
        
        let avatar: Image = {
            if profile.avatar != nil {
                return profile.avatar!
            } else {
                return Image("VKClient")
            }
        }()
        let buttonText: String = {
            if isMyProfile {
                return "Post"
            } else {
                return "Send a message"
            }
        }()
        
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        avatar
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Spacer()
                        VStack {
                            Text(String(posts.count))
                                .fontWeight(.semibold)
                            Text("friends")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text(String(profile.subscribers))
                                .fontWeight(.semibold)
                            Text("subscribers")
                                .font(.footnote)
                        }
                        Spacer()
                        VStack {
                            Text(String(profile.subscriptions))
                                .fontWeight(.semibold)
                            Text("subscriptions")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .padding(16)
                    
                    VStack {
//                        HStack {
//                            Text(name)
//                                .font(.headline)
//                            Spacer()
//                        }
                        HStack {
                            Text(profile.country + ", " + profile.city)
                                .font(.subheadline)
                            Spacer()
                        }
                        if profile.jobTitle != nil {
                            HStack {
                                Text(profile.jobTitle!)
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        if profile.status != nil {
                            Text(profile.status!)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    
                    NavigationLink {
                        ProfileEditView()
                    } label: {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text(buttonText)
                        })
                        .buttonStyle(DefaultButton())
                        .padding(16)
                    }
                    
                    
                    if photos.count > 0 {
                        Divider()
                        ProfilePhotosView(photos: photos)
                    }
                    if videos.count > 0 {
                        Divider()
                        ProfileVideosView(videos: videos)
                    }
                    Divider()
                        
                    
                    HStack {
                        Text("Posts")
                            .foregroundStyle(Color("Text"))
                            .font(.headline)
                            .padding(.top, 10)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    PostView(posts: Mocks.shared.posts)
                }
            }
            .coordinateSpace(name: "scroll")
            .navigationBarTitle(name, displayMode: .inline)
            .navigationBarHidden(false)
        }
        .animation(.default, value: barHidden)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ProfileView(profile: Mocks.shared.profile)
}
