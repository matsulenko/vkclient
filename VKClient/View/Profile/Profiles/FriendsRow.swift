//
//  FriendsRow.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI

struct FriendsRow: View {
    
    var firstName: String?
    var lastName: String?
    var name: String?
    var img: String
    var city: City?
    
    var body: some View {
        let nameText: String = {
            if name != nil {
                return name!
            } else {
                return (firstName ?? "") + " " + (lastName ?? "")
            }
        }()
        
        HStack {
            AsyncImage(url: URL(string: img))
                .scaledToFill()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
                .padding(.trailing, 8)
            VStack {
                HStack {
                    Text(nameText)
                        .lineLimit(1)
                        .foregroundStyle(Color.text)
                        .font(.headline)
                    Spacer()
                }
                if city != nil {
                    HStack {
                        Text(city!.title)
                            .lineLimit(1)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    FriendsRow(firstName: "1", lastName: "1", img: "")
}
