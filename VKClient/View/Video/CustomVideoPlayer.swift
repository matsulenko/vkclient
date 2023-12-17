//
//  CustomVideoPlayer.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    @State var resource: String

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: Bundle.main.url(forResource: resource,
                                                   withExtension: "mov")!)
        player.play()
        controller.player = player
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
}
