//
//  SectionHeaderViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

protocol SectionHeaderViewModel {
    static var reuseIdentifer: String { get }
    var reuseIdentifier: String { get }
    var sectionId: UUID { get set }
}

extension SectionHeaderViewModel {
    static var reuseIdentifer: String {
        String(describing: Self.self)
    }

    var reuseIdentifier: String {
        Self.reuseIdentifer
    }
}
