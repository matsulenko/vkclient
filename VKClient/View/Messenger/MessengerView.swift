//
//  MessengerView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI

struct MessengerView: View {
    @State var profiles: [Profile]
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Messenger")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .padding(20)
                Spacer()
            }
            List(profiles) { profile in
                NavigationLink {
                    MessagesView(messages: Mocks.shared.messages)
                } label: {
                    MessengerRow(profile: profile)
                }
            }
            .listStyle(.plain)
            .border(edges: [.top])
        }
    }
}

#Preview {
    MessengerView(profiles: Mocks.shared.feed.profiles)
}
