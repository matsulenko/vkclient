//
//  MessengerRow.swift
//  VKClient
//
//  Created by Matsulenko on 07.12.2023.
//

import SwiftUI

struct MessengerRow: View {
    @State var profile: Profile
    @State var messages: [Message] = Mocks.shared.messages
    
    var body: some View {
        let avatar: Image = {
            if profile.avatar != nil {
                return profile.avatar!
            } else {
                return Image("VKClient")
            }
        }()
        
        HStack {
            avatar
                .resizable()
                .scaledToFill()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
                .padding(.trailing, 8)
            VStack {
                HStack {
                    Text(messages.first!.profile.name + " " + messages.first!.profile.surname)
                        .foregroundStyle(Color.text)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(messages.last!.text)
                        .lineLimit(1)
                        .foregroundStyle(.gray)
                    Text(messages.last!.postDate)
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    MessengerRow(profile: Mocks.shared.profile2)
}
