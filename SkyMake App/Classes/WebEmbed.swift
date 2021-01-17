//
//  WebEmbed.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 17.01.2021.
//

import Foundation
import WebKit
import SwiftUI

struct WebEmbed: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        // Enable javascript in WKWebView to interact with the web app
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
       return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
            if let url = URL(string: "https://app.deducated.com") {
                webView.load(URLRequest(url: url))
            }
    }
    
}
