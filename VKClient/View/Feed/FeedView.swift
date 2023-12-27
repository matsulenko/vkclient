//
//  FeedView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import KeychainSwift

struct FeedView: View {
    var token: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                    PostView(createNewPost: .constant(false), token: token, isFeed: true)                
                Divider()
            }
            .navigationTitle("Your feed")
        }
    }
}

#Preview {
    FeedView(token: InfoPlist.tokenForPreviews)
}
