//
//  Likes.swift
//  VKClient
//
//  Created by Matsulenko on 19.12.2023.
//

import Foundation

struct LikesResponse: Decodable {
    var response: Likes
}

struct Likes: Decodable, Hashable {
    var likes: Int
}
