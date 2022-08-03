//
//  Item.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import Foundation

struct DataItem: Codable {
    var link: String = ""
    var isDir: Bool = false
    var title: String = ""
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case link
        case isDir = "is_dir"
        case title
        case icon = "ios_icon"
    }
}
