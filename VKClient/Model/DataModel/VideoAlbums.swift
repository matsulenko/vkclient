//
//  VideoAlbums.swift
//  VKClient
//
//  Created by Matsulenko on 23.12.2023.
//

import Foundation

struct VideoAlbumsResponse: Decodable {
    var response: VideoAlbums
}

struct VideoAlbums: Decodable, Hashable {
    var count: Int
    var items: [VideoAlbum]
}

struct VideoAlbum: Decodable, Hashable {
    var count: Int
    var updatedTime: Int
    var id: Int
    var ownerId: Int
    var title: String
    var image: [VideoAlbumImage]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case updatedTime = "updated_time"
        case id = "id"
        case ownerId = "owner_id"
        case title = "title"
        case image = "image"
    }
}

struct VideoAlbumImage: Decodable, Hashable {
    var url: String
}
