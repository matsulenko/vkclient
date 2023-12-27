//
//  Videos.swift
//  VKClient
//
//  Created by Matsulenko on 22.12.2023.
//

import Foundation
import SwiftUI

struct VideosResponse: Decodable {
    var response: Videos
}

struct Videos: Decodable, Hashable {
    var count: Int
    var items: [Video]
    var profiles: [CommentProfile]?
    var groups: [CommentGroup]?
}

struct Video: Decodable, Hashable, Identifiable {
    var addingDate: Int?
    var canComment: Int?
    var canRepost: Int?
    var canAdd: Int?
    var comments: Int?
    var date: Int?
    var description: String?
    var duration: Double?
    var width: Int?
    var height: Int?
    var id: Int
    var image: [VideoImage]
    var ownerId: Int
    var title: String
    var player: String?
    var added: Int
    var type: String
    var views: Int
    var platform: String?
    var likes: VideoLikes?
    var reposts: VideoReposts?
    var contentRestricted: Int?
    
    enum CodingKeys: String, CodingKey {
        case addingDate = "adding_date"
        case canComment = "can_comment"
        case canRepost = "can_repost"
        case canAdd = "can_add"
        case comments = "comments"
        case date = "date"
        case description = "description"
        case duration = "duration"
        case width = "width"
        case height = "height"
        case id = "id"
        case image = "image"
        case ownerId = "owner_id"
        case title = "title"
        case player = "player"
        case added = "added"
        case type = "type"
        case views = "views"
        case platform = "platform"
        case likes = "likes"
        case reposts = "reposts"
        case contentRestricted = "content_restricted"
    }
}

struct VideoImage: Decodable, Hashable {
    var url: String
    var width: Int?
    var height: Int?
}

struct VideoLikes: Decodable, Hashable {
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
    }
}

struct VideoReposts: Decodable, Hashable {
    var count: Int
    var wallCount: Int?
    var mailCount: Int?
    var userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case wallCount = "wall_count"
        case mailCount = "mail_count"
        case userReposted = "user_reposted"
    }
}

struct AddOrDeleteResponse: Decodable, Hashable {
    var response: Int
}
