//
//  WebView.swift
//  VKClient
//
//  Created by Matsulenko on 10.12.2023.
//

import SwiftUI
import WebKit

struct VideoPlayer: UIViewRepresentable {
    
    var url: String
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: URL(string: url )!)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
