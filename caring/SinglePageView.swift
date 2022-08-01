//
//  SinglePageView.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import AlertToast
import SwiftUI
import WebKit

struct SinglePageView: View {
    private var link: String

    init(link: String) {
        self.link = link
    }

    var body: some View {
        VStack {
            SwiftUIWebView(url: self.link)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    private let webView: WKWebView
    init(url: String) {
        webView = WKWebView()
        webView.load(URLRequest.init(url: URL(string: url)!))
    }

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}
