//
//  Comments.swift
//  VKClient
//
//  Created by Matsulenko on 18.12.2023.
//

import Foundation

struct CommentsResponse: Decodable {
    var response: Comments
}

struct Comments: Decodable, Hashable {
    var count: Int
    var items: [Comment]
    var profiles: [CommentProfile]?
    var groups: [CommentGroup]?
}

struct Comment: Decodable, Hashable, Identifiable {
    var id: Int
    var fromId: Int
    var date: Int
    var text: String
    var canEdit: Int?
    var canDelete: Int?
    var attachments: [CommentsAttachment]?
    var likes: CommentLikes
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fromId = "from_id"
        case date = "date"
        case text = "text"
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case attachments = "attachments"
        case likes = "likes"
    }
}

struct CommentProfile: Decodable, Hashable {
    var id: Int
    var photo: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photo = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct CommentGroup: Decodable, Hashable {
    var id: Int
    var photo: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photo = "photo_50"
        case name = "name"
    }
}

struct CommentLikes: Decodable, Hashable {
    var canLike: Int
    var count: Int
    var userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count = "count"
        case userLikes = "user_likes"
    }
}

struct CommentsAttachment: Decodable, Hashable {
    var type: String
    var photo: PhotoAttachment?
    var video: VideoAttachment?
    var link: LinkAttachment?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case photo = "photo"
        case video = "video"
        case link = "link"
    }
}

struct PhotoAttachment: Decodable, Hashable {
    var id: Int
    var ownerId: Int
    var accessKey: String?
    var sizes: [AllPhotosItemSize]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerId = "owner_id"
        case accessKey = "access_key"
        case sizes = "sizes"
    }
}

struct VideoAttachment: Decodable, Hashable {
    var accessKey: String?
    var duration: Double?
    var image: [VideoAttachmentImage]?
    var width: Int?
    var height: Int?
    var id: Int
    var ownerId: Int
    var title: String
    var trackCode: String?
    var type: String
    var liveStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case duration = "duration"
        case image = "image"
        case width = "width"
        case height = "height"
        case id = "id"
        case ownerId = "owner_id"
        case title = "title"
        case trackCode = "track_code"
        case type = "type"
        case liveStatus = "live_status"
    }
}

struct VideoAttachmentImage: Decodable, Hashable {
    var url: String
    var width: Int?
    var height: Int?
}

struct CreateCommentResponse: Decodable, Hashable {
    var response: Int
}

struct DeleteCommentResponse: Decodable, Hashable {
    var response: Int
}

struct LinkAttachment: Decodable, Hashable {
    var url: String
    var caption: String?
    var description: String?
    var photo: LinkAttachmentPhoto?
    var title: String?
}

struct LinkAttachmentPhoto: Decodable, Hashable {
    var sizes: [AllPhotosItemSize]?
    var text: String?
}
