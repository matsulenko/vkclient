//
//  FeedView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI

struct FeedView: View {
    
    @State var feed: Feed
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(feed.profiles) { profile in
                            
                            let image: Image = {
                                if profile.avatar != nil {
                                    return profile.avatar!
                                } else {
                                    return Image("VKClient")
                                }
                            }()
                            
                            NavigationLink {
                                ProfileView(profile: profile, isMyProfile: false)
                            } label: {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(16)
                }
                
                Divider()
                
                PostView(posts: feed.posts)
            }
            .navigationTitle("Your feed")
//            .border(edges: [.top])
        }
    }
}

#Preview {
    FeedView(feed: Mocks.shared.feed)
}
