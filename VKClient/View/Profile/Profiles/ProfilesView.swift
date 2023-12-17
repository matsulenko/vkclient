//
//  ProfilesView.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI

struct ProfilesView: View {
    
    @State var token: String
    @State var userId: Int?
    @State var friends: [Friend] = []
    @State var subscriptions: [SubscriptionGroup] = []
    @State var typeOfProfiles: ListOfProfilesType
    
    var body: some View {
        NavigationStack {
            VStack {
                switch typeOfProfiles {
                case .subscriptions:
                    List(subscriptions, id: \.self) { subscription in
                        NavigationLink {
                            ProfileView(profile: Mocks.shared.profile)
                        } label: {
                            FriendsRow(name: subscription.name, img: subscription.photo)
                        }
                    }
                default:
                    List(friends, id: \.self) { friend in
                        NavigationLink {
                            ProfileView(profile: Mocks.shared.profile)
                        } label: {
                            FriendsRow(firstName: friend.firstName, lastName: friend.lastName, img: friend.photo, city: friend.city)
                        }
                    }
                }
            }
            .listStyle(.inset)
            .navigationBarTitle(typeOfProfiles.rawValue, displayMode: .inline)
        }
        .onAppear {
            switch typeOfProfiles {
            case .subscriptions:
                GetData.shared.getSubscriptions(token: token, userId: userId) { result in
                    switch result {
                    case .success(let subscriptions): self.subscriptions = subscriptions
                    case .failure(let error): print("Something went wrong: \(error.localizedDescription)")
                    }
                }
            default:
                GetData.shared.getFriends(token: token, type: typeOfProfiles, userId: userId) { result in
                    switch result {
                    case .success(let friends): self.friends = friends
                    case .failure(let error): print("Something went wrong: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfilesView(token: "", typeOfProfiles: .friends)
}
