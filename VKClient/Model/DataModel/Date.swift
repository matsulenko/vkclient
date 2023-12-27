//
//  Date.swift
//  VKClient
//
//  Created by Matsulenko on 19.12.2023.
//

import Foundation
import SwiftUI

extension Date {
    var longDateWithTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
    
    init(unixTime: Int) {
        self = NSDate(timeIntervalSince1970: TimeInterval(unixTime)) as Date
    }
}
