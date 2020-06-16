//
//  HTMLStringView.swift
//  TempMail
//
//  Created by Aravind Koneru on 6/6/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
}
