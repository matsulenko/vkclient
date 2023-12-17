//
//  VideoTabView.swift
//  VKClient
//
//  Created by Matsulenko on 04.12.2023.
//

import SwiftUI

struct VideoTabView: View {
    @State var videos: [Video]
    
    var body: some View {
        ForEach(videos) { video in
            VideoRowView(video: video)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    VideoTabView(videos: Mocks.shared.videos)
}
