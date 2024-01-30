//
//  Users.swift
//  VKClient
//
//  Created by Matsulenko on 24.12.2023.
//

import Foundation
import SwiftUI

struct UsersResponse: Decodable {
    var response: [User]
}

struct User: Decodable, Hashable {
    var id: Int
    var deactivated: String?
    var city: City?
    var country: Country?
    var photoId: String?
    var hasPhoto: Int?
    var status: String?
    var occupation: Occupation?
    var career: [Career]?
    var photo: String?
    var firstName: String
    var lastName: String
    var canAccessClosed: Bool?
    var isClosed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deactivated = "deactivated"
        case city = "city"
        case country = "country"
        case photoId = "photo_id"
        case hasPhoto = "has_photo"
        case status = "status"
        case occupation = "occupation"
        case career = "career"
        case photo = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

struct Country: Decodable, Hashable {
    var id: Int
    var title: String
}

struct Occupation: Decodable, Hashable {
    var id: Int?
    var name: String
    var type: String
}

struct Career: Decodable, Hashable {
    var cityId: Int?
    var company: String?
    var countryId: Int?
    var from: Int?
    var position: String?
    var until: Int?
    
    enum CodingKeys: String, CodingKey {
        case cityId = "city_id"
        case company = "company"
        case countryId = "country_id"
        case from = "from"
        case position = "position"
        case until = "until"
    }
}
