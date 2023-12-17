//
//  ContentView.swift
//  VKClient
//
//  Created by Matsulenko on 30.11.2023.
//

import SwiftUI
import KeychainSwift

struct ContentView: View {
    
    @State var token = KeychainSwift().get("accessToken")
    
    var body: some View {
        if token != nil {
            ProfilesView(token: token!, typeOfProfiles: .friends)
        } else {
            WebView(token: $token)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
