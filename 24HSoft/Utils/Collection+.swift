//
//  Collection+.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    var isNotEmpty: Bool { !isEmpty }
}
