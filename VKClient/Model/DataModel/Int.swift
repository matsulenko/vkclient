//
//  Int.swift
//  VKClient
//
//  Created by Matsulenko on 22.12.2023.
//

import Foundation

extension Double {
    var secondsToHoursMinutesSeconds: String {
        if self >= 3600 {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            
            return formatter.string(from: self) ?? ""
        } else {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            
            return formatter.string(from: self) ?? ""
        }
    }
}
