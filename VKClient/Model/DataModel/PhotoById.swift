//
//  PhotoById.swift
//  VKClient
//
//  Created by Matsulenko on 18.12.2023.
//

import Foundation

struct PhotoByIdResponse: Decodable {
    var response: [PhotoById]
}

struct PhotoById: Decodable, Hashable {
    var albumId: Int
    var date: Int
    var id: Int
    var ownerId: Int
    var canComment: Int
    var sizes: [PhotoByIdSize]
    var text: String
    var webViewToken: String
    var likes: PhotoByIdLikes
    var comments: PhotoByIdComments
    var origPhoto: PhotoByIdOrigPhoto
    
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date = "date"
        case id = "id"
        case ownerId = "owner_id"
        case canComment = "can_comment"
        case sizes = "sizes"
        case text = "text"
        case webViewToken = "web_view_token"
        case likes = "likes"
        case comments = "comments"
        case origPhoto = "orig_photo"
    }
}

struct PhotoByIdSize: Decodable, Hashable {
    var type: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}

struct PhotoByIdLikes: Decodable, Hashable {
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
    }
}

struct PhotoByIdComments: Decodable, Hashable {
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

struct PhotoByIdOrigPhoto: Decodable, Hashable {
    var height: Int
    var url: String
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}
