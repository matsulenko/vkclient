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
    var count: Int
    var items: [SubscriptionGroup]
}

struct SubscriptionGroup: Decodable, Hashable {
    var id: Int
    var photo: String
    var firstName: String?
    var lastName: String?
    var name: String
    var type: SubscriptionType
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
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
