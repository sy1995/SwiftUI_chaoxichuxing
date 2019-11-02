//
//  WebView.swift
//  chaoxichuxing
//
//  Created by sunyang on 18.10.19.
//  Copyright © 2019 孙阳. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
      let request: URLRequest
        
      func makeUIView(context: Context) -> WKWebView  {
          return WKWebView()
      }
        
      func updateUIView(_ uiView: WKWebView, context: Context) {
          uiView.load(request)
      }
        
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://lbs.amap.com/console/show/picker")!))
    }
}
