//
//  UserModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

struct UserModel: Codable {
    var id: String? = nil
    var username: String? = nil

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
    }
}
