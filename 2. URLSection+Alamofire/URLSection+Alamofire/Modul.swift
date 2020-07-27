//
//  Modul.swift
//  URLSection+Alamofire
//
//  Created by Huy on 7/27/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import Foundation
//Encodable - dùng cho mã hóa
//Decodable - dùng cho giải mã
//Codable - dùng cho cả mã hóa và giải mã
//Chúng hỗ trợ cho cả class, struct và enum.
class Item: Codable {
    var title: String
    var tags: [String]
    var answer_count: Int
    var score: Int
    var link: String
    var profile_image: String
}
class Items: Codable {
    var items: [Item]
    static func parseData(_ data: Data) -> [Item] {
    do {
        let decoder = JSONDecoder()
        let resultObject = try decoder.decode(Items.self, from: data)
        return resultObject.items
    } catch {
        print("JSON Error: \(error)")
        return []
    }
    }
}
