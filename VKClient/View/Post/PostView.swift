//
//  PostView.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import SwiftUI

struct PostView: View {
    
    @State var posts: [Post]
    
    var body: some View {
        VStack {
            ForEach(posts) { post in
                HStack {
                    PostRow(post: post)
                    Spacer()
                }
                Divider()
            }
        }
    }
}

#Preview {
    PostView(posts: Mocks.shared.posts)
}
