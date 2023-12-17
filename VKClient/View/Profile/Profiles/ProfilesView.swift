//
//  FriendsView.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI

struct FriendsView: View {
    
    @State var token: String
    @State var userId: Int?
    @State var friends: [Friend] = []
    
    var body: some View {
        NavigationStack {
//            ScrollView {
                List(friends, id: \.self) { friend in
                    NavigationLink {
                        ProfileView(profile: Mocks.shared.profile)
                    } label: {
                        FriendsRow(name: friend.firstName, surname: friend.lastName, img: friend.photo)
                    }
                }
                .listStyle(.inset)
//            }
            .navigationBarTitle("Friends", displayMode: .inline)
        }.onAppear {
            GetData.shared.getFriends(token: token, userId: nil) { result in
                switch result {
                case .success(let friends): self.friends = friends
                case .failure(let error): print("Something went wrong: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    FriendsView(token: "")
}
