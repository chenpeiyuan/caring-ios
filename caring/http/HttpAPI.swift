//
//  HttpAPI.swift
//  caring
//
//  Created by Peiyuan Chen on 2022/7/28.
//

import Alamofire
import Foundation

var debug = false

enum HttpAPI {
    static let initLink = "https://caring.ustbtech.cn/data/index.json"

    static func getList(
        link: String,
        onSuccess: @escaping (_ data: [DataItem]) -> Void,
        onFailure: @escaping (_ errMsg: String) -> Void
    ) {
        AF.request(
            link,
            method: .get,
            headers: HTTPHeaders([HTTPHeader.userAgent(Constants.userAgent)])
        ).response { response in
            switch response.result {
            case let .success(data):
                if debug {
                    print("=========================>", link)
                    print(String(decoding: data!, as: UTF8.self))
                }
                let items = try? JSONDecoder().decode([DataItem].self, from: data!)
                if items == nil {
                    onFailure("网络请求失败，请稍后再试")
                    return
                }
                if debug {
                    print(items!)
                    print("<=========================")
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
            method: .get,
            headers: HTTPHeaders([HTTPHeader.userAgent(Constants.userAgent)])
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
