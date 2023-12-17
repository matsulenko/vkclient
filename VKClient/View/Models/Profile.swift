//
//  Profile.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

enum Gender {
    case male
    case female
    case unknown
}

struct Profile: Identifiable {
    var id: Int
    var name: String
    var surname: String
    var gender: Gender
    var birthday: Date
    var country: String
    var city: String
    var numberOfPosts: Int
    var subscriptions: Int
    var subscribers: Int
    var avatar: Image?
    var jobTitle: String?
    var videos: [Video]?
    var photos: [Photo]?
    var photoGalleries: [PhotoGallery]?
    var videoPlaylists: [VideoPlaylist]?
    var posts: [Post]?
    var status: String?
}
