//
//  VideoPlaylist.swift
//  VKClient
//
//  Created by Matsulenko on 02.12.2023.
//

import Foundation
import SwiftUI

struct VideoPlaylist: Identifiable {
    var id: Int
    var title: String
    var image: Image
    var videos: [Video]
    var dateOfUpdate: Date
}
