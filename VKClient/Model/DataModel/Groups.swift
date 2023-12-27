//
//  Groups.swift
//  VKClient
//
//  Created by Matsulenko on 25.12.2023.
//

import Foundation
import SwiftUI

struct GroupsResponse: Decodable {
    var response: Groups
}

struct Groups: Decodable {
    var groups: [Group]
}

struct Group: Decodable, Hashable {
    var id: Int
    var description: String?
    var membersCount: Int?
    var status: String?
    var name: String
    var isClosed: Int
    var photo: String?
    var deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case membersCount = "members_count"
        case status = "status"
        case name = "name"
        case isClosed = "is_closed"
        case photo = "photo_100"
        case deactivated = "deactivated"
    }
}

struct JoinGroupResponse: Decodable {
    var response: Int
}

struct LeaveGroupResponse: Decodable {
    var response: Int
}

struct CheckMembershipResponse: Decodable {
    var response: Int
}


struct GroupsListResponse: Decodable {
    var response: GroupsList
}

struct GroupsList: Decodable, Hashable {
    var count: Int
    var items: [GroupsListItem]
}

struct GroupsListItem: Decodable, Hashable {
    var id: Int
    var name: String
    var isClosed: Int
    var photo: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isClosed = "is_closed"
        case photo = "photo_50"
    }
}
