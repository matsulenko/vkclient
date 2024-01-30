//
//  ProfilesView.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI

struct ProfilesView: View {
    
    let limit = 25
    @State var hasError = false
    var token: String
    var userId: Int?
    var nameOfUser: String?
    @State var friends: [Friend] = []
    @State var subscriptions: [SubscriptionGroup] = []
    var typeOfProfiles: ListOfProfilesType
    @State var profilesLoaded: Int = 0
    var profilesTotalCount: Int?
    
    var body: some View {
        let navBarTitle: String = setTitle()
        
        if hasError {
            Text("Something went wrong")
        } else {
            NavigationStack {
                VStack {
                    switch typeOfProfiles {
                    case .subscriptions:
                        List(subscriptions, id: \.self) { subscription in
                            NavigationLink {
                                if subscription.type == .profile {
                                    ProfileView(token: token, userId: subscription.id)
                                } else {
                                    let groupId = subscription.id * (-1)
                                    ProfileView(token: token, userId: groupId)
                                }
                            } label: {
                                FriendsRow(name: subscription.name, img: subscription.photo)
                            }
                        }
                    default:
                        List(friends, id: \.self) { friend in
                            NavigationLink {
                                ProfileView(token: token, userId: friend.id)
                            } label: {
                                FriendsRow(firstName: friend.firstName, lastName: friend.lastName, img: friend.photo, city: friend.city)
                            }
                        }
                    }
                    if profilesLoaded < profilesTotalCount ?? 0 {
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
                .listStyle(.inset)
                .navigationBarTitle(navBarTitle, displayMode: .inline)
            }
            .onAppear {
                if profilesLoaded == 0 {
                    loadProfiles()
                }
            }
        }
    }
    
    private func setTitle() -> String {
        let titlePrefix: String = {
            if nameOfUser == nil {
                ""
            } else {
                nameOfUser! + ". "
            }
        }()
        
        let titleSuffix: String = {
            switch typeOfProfiles {
            case .friends:
                String(localized: "Friends")
            case .followers:
                String(localized: "Followers")
            case .subscriptions:
                String(localized: "Subscriptions")
            }
        }()
        
        return titlePrefix + titleSuffix
    }
    
    private func loadProfiles() {
        switch typeOfProfiles {
        case .subscriptions:
            Responses.shared.getSubscriptions(token: token, userId: userId, count: limit, offset: nil) { result in
                switch result {
                case .success(let subscriptions): 
                    self.subscriptions = subscriptions
                    profilesLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        default:
            Responses.shared.getFriends(token: token, type: typeOfProfiles, userId: userId, count: limit, offset: nil) { result in
                switch result {
                case .success(let friends): 
                    self.friends = friends
                    profilesLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
    
    private func loadMore() {
        switch typeOfProfiles {
        case .subscriptions:
            Responses.shared.getSubscriptions(token: token, userId: userId, count: limit, offset: profilesLoaded) { result in
                switch result {
                case .success(let moreSubscriptions): 
                    self.subscriptions.append(contentsOf: moreSubscriptions)
                    profilesLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        default:
            Responses.shared.getFriends(token: token, type: typeOfProfiles, userId: userId, count: limit, offset: profilesLoaded) { result in
                switch result {
                case .success(let moreFriends): 
                    self.friends.append(contentsOf: moreFriends)
                    profilesLoaded += limit
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    hasError = true
                }
            }
        }
    }
}

#Preview {
    ProfilesView(token: InfoPlist.tokenForPreviews, typeOfProfiles: .friends, profilesTotalCount: 18)
}
