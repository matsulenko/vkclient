//
//  GroupsView.swift
//  VKClient
//
//  Created by Matsulenko on 25.12.2023.
//

import SwiftUI

struct GroupsView: View {
    
    let limit = 25
    @State var hasError = false
    var token: String
    @State var groups: GroupsList?
    @State var groupsLoaded: Int = 0
    
    var body: some View {
        
        if hasError {
            Text("Something went wrong")
        } else {
            NavigationStack {
                VStack {
                    if groups != nil {
                        if groups!.count == 0 {
                            Text("You are not a member of any group")
                        } else {
                            List(groups!.items, id: \.self) { group in
                                NavigationLink {
                                    let groupId = group.id * (-1)
                                    ProfileView(token: token, userId: groupId)
                                } label: {
                                    FriendsRow(name: group.name, img: group.photo ?? "https://vk.com/images/camera_50.png")
                                }
                            }
                            if groupsLoaded < groups!.count {
                                Button(
                                    action: {
                                        loadMore()
                                    }, label: {
                                        Text("Load more")
                                    })
                                .buttonStyle(DefaultButton())
                                .padding(.horizontal, 26)
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .navigationBarTitle("My groups", displayMode: .inline)
            }
            .onAppear {
                if groupsLoaded == 0 {
                    loadGroups()
                }
            }
        }
    }
    
    private func loadGroups() {
        Responses.shared.getGroupsOfUser(token: token, count: limit, offset: nil) { result in
            switch result {
            case .success(let groups):
                self.groups = groups
                groupsLoaded += limit
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
    
    private func loadMore() {
        Responses.shared.getGroupsOfUser(token: token, count: limit, offset: groupsLoaded) { result in
            switch result {
            case .success(let moreGroups):
                self.groups!.items.append(contentsOf: moreGroups.items)
                groupsLoaded += limit
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
}

#Preview {
    GroupsView(token: InfoPlist.tokenForPreviews)
}
