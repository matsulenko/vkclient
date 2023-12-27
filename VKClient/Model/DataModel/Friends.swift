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
    var count: Int
    var items: [Friend]
}

struct Friend: Decodable, Hashable {
    var id: Int
    var photo: String
    var firstName: String
    var lastName: String
    var city: City?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case city = "city"
    }
}

struct City: Decodable, Hashable {
    var id: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
    }
}

struct AreFriendsResponse: Decodable {
    var response: [AreFriends]
}

struct AreFriends: Decodable, Hashable {
    var friendStatus: Int
    var userId: Int
    
    enum CodingKeys: String, CodingKey {
        case friendStatus = "friend_status"
        case userId = "user_id"
    }
}

struct AddToFriendsResponse: Decodable {
    var response: Int
}

struct DeleteFriendResponse: Decodable {
    var response: DeleteFriend
}

struct DeleteFriend: Decodable {
    var success: Int
    var friendDeleted: Int?
    var outRequestDeleted: Int?
    var inRequestDeleted: Int?
    var suggestionDeleted: Int?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case friendDeleted = "friend_deleted"
        case outRequestDeleted = "out_request_deleted"
        case inRequestDeleted = "in_request_deleted"
        case suggestionDeleted = "suggestion_deleted"
    }
}
