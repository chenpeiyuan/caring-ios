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
    @State private var html = ""
    @State private var showLoading = true
    @State private var showError = false
    @State private var errMsg = ""

    init(link: String) {
        self.link = link
    }

    var body: some View {
        VStack {
            if !showLoading {
                SwiftUIWebView(html: self.html)
            } else {
                SwiftUIWebView(html: "")
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear {
            HttpAPI.getHTML(link: link) { html in
                self.html = html
                self.showLoading = false
            } onFailure: { errMsg in
                self.showLoading = false
                self.errMsg = errMsg
                self.showError = true
            }
        }
        .toast(isPresenting: $showLoading) {
            AlertToast(type: .loading, style: AlertToast.AlertStyle.style(titleFont: Font.title2))
        }
        .toast(isPresenting: $showError) {
            AlertToast(type: .regular,
                       title: self.errMsg, style: AlertToast.AlertStyle.style(titleFont: Font.title2))
        }
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    private let webView: WKWebView
    init(html: String) {
        webView = WKWebView()
        webView.loadHTMLString(html, baseURL: nil)
    }

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}