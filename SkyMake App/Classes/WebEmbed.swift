//
//  WebEmbed.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 17.01.2021.
//

import Foundation
import WebKit
import SwiftUI

public struct WebEmbed {
    
    private let webView: WKWebView = WKWebView()

    public func load(url: URL) {
        let url_request = URLRequest(url: url)
        webView.customUserAgent = "SkyMakeApp/V1.0"
        webView.load(url_request)
    }
    
    public func getCurrentUrl() -> URL?{
        let ret_val = webView.url
        return ret_val
    }
    
    public func checkIfCurrentUrlContains(whatwearelookingfor: String) -> Bool {
        if(webView.url?.absoluteString.contains(whatwearelookingfor) == true){
            return Bool(true)
        }
        else {
            return Bool(false)
        }
    }
        
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {

        var parent: WebEmbed
        init(parent: WebEmbed){
            self.parent = parent
        }
        
        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
}

extension WebEmbed: UIViewRepresentable {

    public typealias UIViewType = WKWebView

    public func makeUIView(context: UIViewRepresentableContext<WebEmbed>) -> WKWebView {

        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebEmbed>) {

    }
}
