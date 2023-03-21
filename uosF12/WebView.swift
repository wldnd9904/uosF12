//
//  WebView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/14.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var urlToLoad : String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlToLoad) else{
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webview = WKWebView()
        //웹뷰 로드
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlToLoad: "https://portal.uos.ac.kr")
    }
}
