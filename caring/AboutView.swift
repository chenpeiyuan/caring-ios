//
//  AboutView.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/8/3.
//

import SwiftUI

func GetAppIcon() -> UIImage {
    var appIcon: UIImage! {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.first else { return nil }
        return UIImage(named: lastIcon)
    }
    return appIcon
}

func getDisplayName() -> String? {
    return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
}

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

struct AboutView: View {
    var body: some View {
        VStack {
            Image(uiImage: GetAppIcon())
                .padding(.bottom, 10)
            Text(getDisplayName() ?? "爱老助手")
                .padding(.bottom, 10)
                .font(.title)
            if appVersion != nil {
                Text("Version " + appVersion!)
                    .font(.title3)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("关于"))
        .navigationBarHidden(false)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
