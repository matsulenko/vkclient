//
//  Message.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Hashable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var profile: Profile
    var text: String
    var postDate: String
    var attachedPhotos: [Photo]?
    var attachedVideos: [Video]?
    var isMyMessage: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
