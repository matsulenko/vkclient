//
//  Attachments.swift
//  VKClient
//
//  Created by Matsulenko on 24.12.2023.
//

import Foundation

public final class Attachments {
    
    static let shared: Attachments = {
        let instance = Attachments()
        
        return instance
    }()
    
    func attachedLinks(attachments: [CommentsAttachment]) -> [LinkAttachment]? {
        var attachedLinks: [LinkAttachment] = []
        for attachment in attachments {
            if let attachedLink = attachment.link {
                attachedLinks.append(attachedLink)
            }
        }
        
        if attachedLinks.count > 0 {
            return attachedLinks
        } else {
            return nil
        }
    }
    
    func attachedPhotos(attachments: [CommentsAttachment]) -> [PhotoAttachment]? {
        var attachedPhotos: [PhotoAttachment] = []
        for attachment in attachments {
            if let attachedPhoto = attachment.photo {
                attachedPhotos.append(attachedPhoto)
            }
        }
        
        if attachedPhotos.count > 0 {
            return attachedPhotos
        } else {
            return nil
        }
    }
    
    func attachedVideos(attachments: [CommentsAttachment]) -> [VideoAttachment]? {
        var attachedVideos: [VideoAttachment] = []
        for attachment in attachments {
            if let attachedVideo = attachment.video {
                attachedVideos.append(attachedVideo)
            }
        }
        
        if attachedVideos.count > 0 {
            return attachedVideos
        } else {
            return nil
        }
    }
}
