//
//  Friends.swift
//  VKClient
//
//  Created by Matsulenko on 11.12.2023.
//

import Foundation

struct FriendsResponse: Decodable {
    var response: Friends
}

struct Friends: Decodable {
    var items: [Friend]
}

struct Friend: Decodable, Hashable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.lastName < rhs.lastName
    }
    
    var photo: String
    var firstName: String
    var lastName: String
    var city: City
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case city = "city"
    }
}

struct City: Decodable, Hashable {
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
