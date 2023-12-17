//
//  WebView.swift
//  VKClient
//
//  Created by Matsulenko on 10.12.2023.
//

import Foundation
import SwiftUI
import WebKit
import KeychainSwift

struct WebView: UIViewRepresentable {
    
    @Binding var token: String?
    
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: InfoPlist.clientId),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "offline")
        ]
        
        let request = URLRequest(url: urlComponents.url ?? URL(string: "https://matsulenko.ru")!)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator { token in
            self.token = token
        }
    }
    
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    let keychain = KeychainSwift()
    
    var token: (String) -> ()
    
    init(token: @escaping (String) -> Void) {
        self.token = token
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = 
                navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components (separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String:String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        if let accessToken = params["access_token"] {
            token(accessToken)
            keychain.set(accessToken, forKey: "accessToken")
            if let expiresIn = params["expires_in"] {
                print("expiresIn", expiresIn)
            }
        }
                
        decisionHandler(.cancel)
    }
}



//    typealias UIViewType = UIView
//    func makeUIView(context: Context) -> UIView {
//
//        let vkid: VKID = try! VKID(config: .init(appCredentials: .init(clientId: InfoPlist.clientId!, clientSecret: InfoPlist.clientSecret!)))
//
//        let oneTap = OneTapButton(
//            layout: .regular(
//                height: .medium(.h44),
//                cornerRadius: 8
//            ),
//            presenter: .custom(self),
//            onCompleteAuth: nil
//        )
//        return vkid.ui(for: oneTap).uiView()
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//
//    }


//    let url = "https://matsulenko.ru"
//https://matsulenko.ru/authentication-vk
