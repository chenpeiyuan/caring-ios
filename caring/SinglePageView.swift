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
    private var webView: SwiftUIWebView

    init(link: String) {
        self.link = link
        webView = SwiftUIWebView(url: self.link)
    }

    func share() {
        guard let urlShare = webView.url() else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }

    var body: some View {
        VStack {
            self.webView
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    share()
                } label: {
                    Image(systemName: "link")
                }
            }
        }
    }
}

struct SinglePageView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePageView(link: "https://caring.ustbtech.cn/data/ios/font-setting/")
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    private let webView: WKWebView
    init(url: String) {
        webView = WKWebView()
        webView.customUserAgent = Constants.userAgent
        webView.load(URLRequest(url: URL(string: url)!))
    }

    func url() -> URL? {
        return webView.url
    }

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}
