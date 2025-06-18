//
//  PhotoModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

struct PhotoModel: Decodable {
    var id: String? = nil
    var color: String? = nil
    var description: String? = nil
    var altDescription: String? = nil
    var urls: UrlsModel? = nil
    var likes: Int? = nil
    var user: UserModel? = nil

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case color = "color"
        case description = "description"
        case altDescription = "alt_description"
        case urls = "urls"
        case likes = "likes"
    }
}
