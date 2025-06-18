//
//  CellViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

protocol CellViewModel {
    static var reuseIdentifer: String { get }
    var reuseIdentifier: String { get }

    var id: UUID { get }
    var sectionId: UUID? { get }
    var actionBlock: (() -> Void)? { get set }
}

extension CellViewModel {
    static var reuseIdentifer: String {
        String(describing: Self.self)
    }

    var reuseIdentifier: String {
        Self.reuseIdentifer
    }
}
