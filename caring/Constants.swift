//
//  Constants.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/8/3.
//

import Foundation

class Constants {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let userAgent = appVersion == nil ? "Caring-iOS-unknown" : "Caring-iOS-" + appVersion!
}
