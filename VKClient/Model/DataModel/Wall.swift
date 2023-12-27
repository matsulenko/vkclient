//
//  Wall.swift
//  VKClient
//
//  Created by Matsulenko on 24.12.2023.
//

import Foundation
import SwiftUI

struct WallResponse: Decodable {
    var response: Wallposts
}

struct Wallposts: Decodable, Hashable {
    var count: Int?
    var items: [Wallpost]
    var profiles: [CommentProfile]?
    var groups: [CommentGroup]?
    var nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
        case profiles = "profiles"
        case groups = "groups"
        case nextFrom = "next_from"
    }
}

struct Wallpost: Decodable, Hashable {
    var copyHistory: [WallHistory]?
    var canDelete: Int?
    var comments: WallComments
    var hash: String?
    var type: String
    var attachments: [CommentsAttachment]?
    var date: Int
    var fromId: Int?
    var id: Int
    var isArchived: Bool?
    var likes: WallLikes
    var ownerId: Int
    var reposts: WallReposts
    var text: String
    var views: WallViews?
    var sourceId: Int?
    
    enum CodingKeys: String, CodingKey {
        case copyHistory = "copy_history"
        case canDelete = "can_delete"
        case comments = "comments"
        case hash = "hash"
        case type = "type"
        case attachments = "attachments"
        case date = "date"
        case fromId = "from_id"
        case id = "id"
        case isArchived = "is_archived"
        case likes = "likes"
        case ownerId = "owner_id"
        case reposts = "reposts"
        case text = "text"
        case views = "views"
        case sourceId = "source_id"
    }
}

struct WallComments: Decodable, Hashable {
    var canPost: Int
    var canView: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case canView = "can_view"
        case count = "count"
    }
}

struct WallLikes: Decodable, Hashable {
    var count: Int
    var userLikes: Int
    var repostDisabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
        case repostDisabled = "repost_disabled"
    }
}

struct WallReposts: Decodable, Hashable {
    var count: Int
    var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userReposted = "user_reposted"
    }
}

struct WallViews: Decodable, Hashable {
    var count: Int
}

struct WallHistory: Decodable, Hashable {
    var type: String
    var attachments: [CommentsAttachment]?
    var date: Int
    var fromId: Int?
    var id: Int
    var ownerId: Int
    var postSource: PostSource?
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case attachments = "attachments"
        case date = "date"
        case fromId = "from_id"
        case id = "id"
        case ownerId = "owner_id"
        case postSource = "post_source"
        case text = "text"
    }
}

struct PostSource: Decodable, Hashable {
    var type: String?
}

struct CreatePostResponse: Decodable {
    var response: CreatePost
}

struct CreatePost: Decodable, Hashable {
    var postId: Int?
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
    }
}
