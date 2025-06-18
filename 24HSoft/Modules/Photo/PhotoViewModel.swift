//
//  PhotoViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

protocol PhotoViewModelProtocol {
    var username: String? { get set }
    var photoUrl: String { get set }
}

final class PhotoViewModel: PhotoViewModelProtocol {
    var username: String?
    var photoUrl: String

    init(username: String?, photoUrl: String) {
        self.username = username
        self.photoUrl = photoUrl
    }
}

