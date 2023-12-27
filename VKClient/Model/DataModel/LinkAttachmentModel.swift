//
//  LinkAttachmentModel.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import Foundation
import SwiftData

@Model
final class LinkAttachmentModel {
    var url: String
    var caption: String?
    var descriptionText: String?
    var title: String?
    
    init(url: String, caption: String? = nil, descriptionText: String? = nil, title: String? = nil) {
        self.url = url
        self.caption = caption
        self.descriptionText = descriptionText
        self.title = title
    }
}
