//
//  ContentView.swift
//  WebKitApp
//
//  Created by 박지혜 on 7/8/24.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.apple.com")!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

// UIViewRepresentable - SwiftUI와 UIKit 통합
/// WebView는 UIKit의 요소
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
