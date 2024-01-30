//
//  WallpostModel.swift
//  VKClient
//
//  Created by Matsulenko on 26.12.2023.
//

import Foundation
import SwiftData

@Model
final class WallpostModel {
    @Relationship(deleteRule: .cascade) var copyHistory = [WallHistoryModel]()
    @Relationship(deleteRule: .cascade) var linkAttachments = [LinkAttachmentModel]()
    var date: Int
    var fromId: Int
    var fromName: String
    var id: Int
    var ownerId: Int
    var text: String
    var saveDate: Date
    
    init(copyHistory: [WallHistoryModel] = [WallHistoryModel](), linkAttachments: [LinkAttachmentModel] = [LinkAttachmentModel](), date: Int, fromId: Int, fromName: String, id: Int, ownerId: Int, text: String, saveDate: Date) {
        self.copyHistory = copyHistory
        self.linkAttachments = linkAttachments
        self.date = date
        self.fromId = fromId
        self.fromName = fromName
        self.id = id
        self.ownerId = ownerId
        self.text = text
        self.saveDate = saveDate
    }
}


