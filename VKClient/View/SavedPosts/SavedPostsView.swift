//
//  SavedPostsView.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import SwiftData
import SwiftUI

struct SavedPostsView: View {
    var token: String
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\WallpostModel.saveDate, order: .reverse)]) var storedPosts: [WallpostModel]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(storedPosts, id: \.self) { storedPost in
                    SavedPostsRow(token: token, post: storedPost)
                    
                    Divider()
                }
                
                if storedPosts.isEmpty {
                    VStack {
                        Text("There are no saved posts")
                            .font(.title2)
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                        Text("Tap a \"bookmark\" icon under a post to save it")
                            .font(.subheadline)
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                    }
                    .padding(16)
                }
            }
            .navigationBarTitle("Saved posts", displayMode: .inline)
            .animation(.easeInOut, value: storedPosts)
        }
    }
}

#Preview {
    SavedPostsView(token: "")
        .modelContainer(for: WallpostModel.self)
}
