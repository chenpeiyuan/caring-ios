//
//  ContentView.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()
let backgroundColor = UIColor(red: 242.0 / 255, green: 241.0 / 255, blue: 246.0 / 255, alpha: 1)

struct ContentView: View {
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = backgroundColor

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }

    var body: some View {
        NavigationView {
            ListPageView(link: HttpAPI.initLink, title: "首页")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
