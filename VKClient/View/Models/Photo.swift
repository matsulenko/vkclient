//
//  Photo.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import Foundation
import SwiftUI

struct Photo: Identifiable {
    var id: Int
    var description: String
    var image: Image
    var album: String?
    var likes: Int
    var postDate: Date
    var authorName: String
    var authorAvatar: Image
    var comments: Int
    var liked: Bool
}
