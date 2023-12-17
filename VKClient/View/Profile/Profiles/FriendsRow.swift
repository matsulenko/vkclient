//
//  FriendsRow.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendsRow: View {
    
    var firstName: String?
    var lastName: String?
    var name: String?
    var img: String
    var city: City?
    
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
                    Text(name != nil ? name! : (firstName ?? "") + " " + (lastName ?? "") + (city?.title ?? ""))
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
    FriendsRow(firstName: "1", lastName: "1", img: "", city: City(title: "Moscow"))
}
