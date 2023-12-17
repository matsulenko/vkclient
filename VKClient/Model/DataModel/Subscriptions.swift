//
//  Subscriptions.swift
//  VKClient
//
//  Created by Matsulenko on 14.12.2023.
//

import Foundation

enum SubscriptionType: String, Decodable {
    case page = "page"
    case profile = "profile"
}

struct SubscriptionsResponse: Decodable {
    var response: SubscriptionGroups
}

struct SubscriptionGroups: Decodable {
    var items: [SubscriptionGroup]
}

struct SubscriptionGroup: Decodable, Hashable {
    var photo: String
    var firstName: String?
    var lastName: String?
    var name: String
    var type: SubscriptionType
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.photo = try container.decode(String.self, forKey: .photo)
        self.type = try container.decode(SubscriptionType.self, forKey: .type)
        
        switch type {
        case .page:
            self.name = try container.decode(String.self, forKey: .name)
        case .profile:
            self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            self.name = self.firstName! + " " + self.lastName!
        }
    }
}


//struct SubscriptionsResponse: Decodable {
//    var response: Subscriptions
//}
//
//struct Subscriptions: Decodable {
//    var users: SubscriptionUsers
//    var groups: SubscriptionGroups
//}
//
//struct SubscriptionUsers: Decodable {
//    var items: [SubscriptionUser]
//}
//
//struct SubscriptionGroups: Decodable {
//    var items: [SubscriptionGroup]
//}
//
//struct SubscriptionUser: Decodable, Hashable {
//    var photo: String
//    var firstName: String
//    var lastName: String
//    
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case photo = "photo_50"
//    }
//}
//
//struct SubscriptionGroup: Decodable, Hashable {
//    var photo: String
//    var name: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case photo = "photo_50"
//    }
//}
