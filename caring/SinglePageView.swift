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
    @State private var showLoading = false
    @State private var showError = false
    @State private var showReload = false
    @State private var errMsg = ""

    init(link: String) {
        self.link = link
    }
    
    func loadContent() {
        showLoading = true
        showError = false
        HttpAPI.getHTML(link: link) { html in
            self.html = html
            self.showLoading = false
            self.showReload = false
        } onFailure: { errMsg in
            self.showLoading = false
            self.errMsg = errMsg
            self.showError = true
            self.showReload = true
        }
    }

    var body: some View {
        VStack {
            if showReload {
                Spacer()
                Button {
                    loadContent()
                } label: {
                    Label("重新加载", systemImage: "arrow.clockwise.circle")
                        .font(.title2)
                }
                Spacer()
                Spacer()
            } else {
                if !showLoading {
                    SwiftUIWebView(html: self.html, url: self.link)
                } else {
                    SwiftUIWebView(html: "", url: self.link)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear {
            loadContent()
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
    init(html: String, url: String) {
        webView = WKWebView()
        webView.loadHTMLString(html, baseURL: URL(string: url))
    }

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}
