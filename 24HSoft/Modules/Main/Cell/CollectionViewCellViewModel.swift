//
//  CollectionViewCellViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

struct CollectionViewCellViewModel: CellViewModel {
    let photoName: String?
    let description: String?
    let descriptionColorName: String?
    let likes: Int?

    var id: UUID = UUID()
    var sectionId: UUID? = nil
    var actionBlock: (() -> Void)?
}
