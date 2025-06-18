//
//  ConfigurableCollectionViewCell.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit.UICollectionViewCell

protocol ConfigurableCollectionViewCell: UICollectionViewCell {
    func configure(viewModel: CellViewModel)
}
