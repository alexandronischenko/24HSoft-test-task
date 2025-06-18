//
//  UrlsModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

struct UrlsModel: Decodable {
    var thumb: String? = nil
    var regular: String? = nil

    enum CodingKeys: String, CodingKey {
        case thumb = "thumb"
        case regular = "regular"
    }
}
