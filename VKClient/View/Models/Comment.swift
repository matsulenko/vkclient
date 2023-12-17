//
//  Comment.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

struct Comment: Identifiable {
    var id: Int
    var authorName: String
    var authorAvatar: Image
    var text: String
    var likes: Int
    var postDate: String
    var liked: Bool
    var isReply: Bool
    var attachedPhotos: [Photo]?
    var attachedVideos: [Video]?
}
