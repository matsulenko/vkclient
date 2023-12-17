//
//  Video.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import Foundation
import SwiftUI

struct Video: Identifiable {
    var id: Int
    var title: String
    var description: String
    var fileName: String
    var preview: Image
    var views: Int
    var likes: Int
    var postDate: String
    var authorName: String
    var authorAvatar: Image
    var authorSubscribers: Int
    var length: String
    var liked: Bool
}
