//
//  SearchView.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import SwiftUI

enum SearchTab: String, CaseIterable, Identifiable {
    case videos
    case friends
    
    var id: String { self.rawValue }
}

struct SearchView: View {
    var token: String
    @State var selectedTab: SearchTab = .videos
    @State var query: String = ""
    @State var isLinkActive = false
    @State var hasError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Search")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Picker(selectedTab.id, selection: $selectedTab) {
                    Text("Videos").tag(SearchTab.videos)
                    Text("Friends").tag(SearchTab.friends)
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                
                let searchText: String = {
                    switch selectedTab {
                    case .videos: String(localized: "Search videos")
                    case .friends: String(localized: "Search friends")
                    }
                }()
                
                HStack {
                    TextField(searchText, text: $query, axis: .horizontal)
                        .lineLimit(1)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                NavigationLink(value: isLinkActive) {
                    Button(
                        action: {
                            if query == "" {
                                hasError = true
                            } else {
                                hasError = false
                                isLinkActive.toggle()
                            }
                        }, label: {
                            Text("Search")
                        })
                    .buttonStyle(DefaultButton())
                    .padding()
                    .frame(width: 200)
                    .navigationDestination(isPresented: $isLinkActive) {
                        switch selectedTab {
                        case .videos:
                            VideoPlaylistView(token: token, playlistName: query, isSearch: true, query: query)
                        case .friends:
                            UserSearchView(token: token, query: query)
                        }
                    }
                }
                if hasError {
                    Text("Search query is empty")
                        .foregroundStyle(.red)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    SearchView(token: InfoPlist.tokenForPreviews)
}
