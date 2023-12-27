//
//  Count.swift
//  VKClient
//
//  Created by Matsulenko on 25.12.2023.
//

import Foundation

struct CountResponse: Decodable {
    var response: CountGroup
}

struct CountGroup: Decodable {
    var count: Int
}
