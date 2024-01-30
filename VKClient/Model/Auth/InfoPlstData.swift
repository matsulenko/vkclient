//
//  InfoPlstData.swift
//  VKClient
//
//  Created by Matsulenko on 09.12.2023.
//

import Foundation

enum InfoPlist {
    static var clientId: String? {
        Bundle.main.infoDictionary?["CLIENT_ID"] as? String
    }
    
    static var tokenForPreviews: String = ""
}
