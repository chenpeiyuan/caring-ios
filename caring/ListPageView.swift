//
//  ListView.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import AlertToast
import SwiftUI
import WebKit

struct ListPageView: View {
    private var link: String
    private var title: String
    @State private var isLoading: Bool = true
    @State private var items: [DataItem] = []

    @State private var showLoading = false
    @State private var showError = false
    @State private var errMsg = ""

    init(link: String, title: String) {
        self.link = link
        self.title = title
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< items.count, id: \.self) { idx in
                    if items[idx].isDir {
                        NavigationLink(
                            destination: ListPageView(link: items[idx].link, title: items[idx].title)
                        ) {
                            HStack {
                                Image(systemName: items[idx].icon ?? "star.circle")
                                Text(items[idx].title)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                            }
                        }
                        .padding(.vertical, 10)
                        .font(.title2)
                        .foregroundColor(.primary)

                        if idx != items.count - 1 {
                            Divider()
                        }
                    } else {
                        NavigationLink(
                            destination: SinglePageView(link: items[idx].link)
                        ) {
                            HStack {
                                Image(systemName: items[idx].icon ?? "star.circle")
                                Text(items[idx].title)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                            }
                        }
                        .padding(.vertical, 10)
                        .font(.title2)
                        .foregroundColor(.primary)

                        if idx != items.count - 1 {
                            Divider()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(Text(title))
        .navigationBarHidden(false)
        .onAppear {
            showLoading = true
            HttpAPI.getList(link: link) { data in
                self.items = data
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListPageView(link: HttpAPI.initLink, title: "首页")
    }
}
