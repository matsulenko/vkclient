//
//  Feed.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

struct Feed: Identifiable {
    var id: Int
    var profiles: [Profile]
    var posts: [Post]
}
