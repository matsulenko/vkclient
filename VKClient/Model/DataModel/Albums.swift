//
//  Albums.swift
//  VKClient
//
//  Created by Matsulenko on 20.12.2023.
//

import Foundation

struct AlbumsResponse: Decodable {
    var response: Albums
}

struct Albums: Decodable {
    var count: Int
    var items: [Album]
}

struct Album: Decodable, Hashable {
    var id: Int
    var ownerId: Int
    var size: Int
    var title: String
    var created: Int?
    var description: String?
    var sizes: [AlbumSize]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerId = "owner_id"
        case size = "size"
        case title = "title"
        case created = "created"
        case description = "description"
        case sizes = "sizes"
    }
}

struct AlbumSize: Decodable, Hashable {
    var height: Int?
    var type: String
    var width: Int?
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case type = "type"
        case width = "width"
        case url = "url"
    }
}
