//
//  Post.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    var id: Int
    var profile: Profile
    var description: String
    var likes: Int
    var views: Int
    var attachedPhotos: [Photo]?
    var attachedVideos: [Video]?
    var postDate: String
    var liked: Bool
    var comments: Int
}
