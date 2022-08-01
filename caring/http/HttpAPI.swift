//
//  HttpAPI.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import Alamofire
import Foundation

class HttpAPI {
    static let initLink = "https://caring.ustbtech.cn/data/index.json"

    static func getList(
        link: String,
        onSuccess: @escaping (_ data: [DataItem]) -> Void,
        onFailure: @escaping (_ errMsg: String) -> Void
    ) {
        AF.request(
            link,
            method: .get
        ).response { response in
            switch response.result {
            case let .success(data):
                let items = try? JSONDecoder().decode([DataItem].self, from: data!)
                if items == nil {
                    onFailure("网络请求失败，请稍后再试")
                    return
                }
                onSuccess(items!)
            case .failure:
                onFailure("网络请求失败，请稍后再试")
            }
        }
    }

    static func getHTML(
        link: String,
        onSuccess: @escaping (_ html: String) -> Void,
        onFailure: @escaping (_ errMsg: String) -> Void
    ) {
        AF.request(
            link,
            method: .get
        ).response { response in
            switch response.result {
            case let .success(data):
                onSuccess(String(decoding: data!, as: UTF8.self))
            case .failure:
                onFailure("网络请求失败，请稍后再试")
            }
        }
    }
}
