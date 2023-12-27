//
//  Reposts.swift
//  VKClient
//
//  Created by Matsulenko on 25.12.2023.
//

import Foundation

struct RepostResponse: Decodable {
    var response: Reposts
}

struct Reposts: Decodable, Hashable {
    var success: Int
    var post_id: Int?
    var repostsCount: Int
    var likesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case post_id = "post_id"
        case repostsCount = "reposts_count"
        case likesCount = "likes_count"
    }
}
