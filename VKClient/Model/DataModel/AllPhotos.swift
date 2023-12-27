//
//  AllPhotos.swift
//  VKClient
//
//  Created by Matsulenko on 17.12.2023.
//

import Foundation

struct AllPhotosResponse: Decodable {
    var response: AllPhotos
}

struct AllPhotos: Decodable {
    var count: Int
    var items: [AllPhotosItem]
}

struct AllPhotosItem: Decodable, Hashable {
    var date: Int
    var id: Int
    var ownerId: Int
    var sizes: [AllPhotosItemSize]
    var webViewToken: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case id = "id"
        case ownerId = "owner_id"
        case sizes = "sizes"
        case webViewToken = "web_view_token"
    }
}

struct AllPhotosItemSize: Decodable, Hashable {
    var type: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}
