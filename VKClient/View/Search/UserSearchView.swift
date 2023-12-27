//
//  UserSearchView.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import Foundation
import SwiftUI

struct UserSearchView: View {
    
    let limit = 25
    @State var hasError = false
    var token: String
    var query: String
    @State var users: Friends?
    @State var groupsLoaded: Int = 0
    @State var titleText = "Search results"
    
    var body: some View {
        
        if hasError {
            Text("Something went wrong")
        } else {
            NavigationStack {
                VStack {
                    if users != nil {
                        if users!.count == 0 {
                            Text("No results")
                        } else {
                            List(users!.items, id: \.self) { user in
                                NavigationLink {
                                    ProfileView(token: token, userId: user.id)
                                } label: {
                                    FriendsRow(firstName: user.firstName, lastName: user.lastName, img: user.photo, city: user.city)
                                }
                            }
                            if groupsLoaded < users!.count {
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
                .navigationBarTitle(titleText, displayMode: .inline)
            }
            .onAppear {
                if groupsLoaded == 0 {
                    loadGroups()
                }
            }
        }
    }
    
    private func getName(firstName: String, lastName: String) -> String {
        return firstName + " " + lastName
    }
    
    private func loadGroups() {
        Responses.shared.searchUsers(token: token, q: query, count: limit, offset: nil) { result in
            switch result {
            case .success(let users):
                self.users = users
                groupsLoaded += limit
                setTitle()
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
    
    private func loadMore() {
        Responses.shared.searchUsers(token: token, q: query, count: limit, offset: groupsLoaded) { result in
            switch result {
            case .success(let moreUsers):
                self.users!.items.append(contentsOf: moreUsers.items)
                groupsLoaded += limit
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                hasError = true
            }
        }
    }
    
    private func setTitle() {
        guard let users else { return }
        
        let suffix = ": " + String(format: NSLocalizedString("results", comment: ""), users.count)
        self.titleText = query + suffix
    }
}

#Preview {
    UserSearchView(token: InfoPlist.tokenForPreviews, query: "Иван Васильев")
}
