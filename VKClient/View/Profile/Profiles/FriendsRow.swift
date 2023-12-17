//
//  FriendsRow.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendsRow: View {
    
    @State var friend: Friend = Friend(photo: "", firstName: "Name", lastName: "Surname")
    var name: String
    var surname: String
    var img: String
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: img))
                .resizable()
                .scaledToFill()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
                .padding(.trailing, 8)
            VStack {
                HStack {
                    Text(name + " " + surname)
                        .foregroundStyle(Color.text)
                        .font(.headline)
                    Spacer()
                }
            }
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    FriendsRow(name: "1", surname: "1", img: "")
}
