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

func shareApp() {
    guard let urlShare = URL(string: "https://apps.apple.com/cn/app/%E7%88%B1%E8%80%81%E5%8A%A9%E6%89%8B/id1638156311") else { return }
    let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()

            Image(uiImage: GetAppIcon())
                .padding(.bottom, 10)
            Text(getDisplayName() ?? "爱老助手")
                .padding(.bottom, 10)
                .font(.title)
            if Constants.appVersion != nil {
                Text("Version " + Constants.appVersion!)
                    .font(.title3)
            }

            Button {
                shareApp()
            } label: {
                Label("推荐给好友", systemImage: "link")
                    .font(.title3)
            }
            .padding(.vertical)

            Spacer()

            HStack {
                Link(destination: URL(string: "https://caring.ustbtech.cn/page/term/privacy-policy/")!) {
                    Text("隐私协议")
                }
            }

            HStack {
                Link(destination: URL(string: "https://github.com/chenpeiyuan/caring-ios/")!) {
                    Text("iOS开源地址")
                }

                Link(destination: URL(string: "https://github.com/chenpeiyuan/caring-data/")!) {
                    Text("网站开源地址")
                }
            }
            .padding(.vertical, 5)
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
