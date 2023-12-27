//
//  WallHistoryModel.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import Foundation
import SwiftData

@Model
final class WallHistoryModel {
    var type: String
    @Relationship(deleteRule: .cascade) var linkAttachments = [LinkAttachmentModel]()
    var date: Int
    var fromId: Int?
    var fromName: String
    var id: Int
    var ownerId: Int
    var text: String
    
    init(type: String, linkAttachments: [LinkAttachmentModel] = [LinkAttachmentModel](), date: Int, fromId: Int? = nil, fromName: String, id: Int, ownerId: Int, text: String) {
        self.type = type
        self.linkAttachments = linkAttachments
        self.date = date
        self.fromId = fromId
        self.fromName = fromName
        self.id = id
        self.ownerId = ownerId
        self.text = text
    }
}
