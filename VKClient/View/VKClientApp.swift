//
//  VKClientApp.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftData
import SwiftUI

@main
struct VKClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: WallpostModel.self)
    }
}
