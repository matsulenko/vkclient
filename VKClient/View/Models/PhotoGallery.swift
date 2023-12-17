//
//  PhotoGallery.swift
//  VKClient
//
//  Created by Matsulenko on 01.12.2023.
//

import Foundation
import SwiftUI

struct PhotoGallery: Identifiable {
    var id: Int
    var title: String
    var description: String
    var photos: [Photo]
    var dateOfUpdate: Date
}
