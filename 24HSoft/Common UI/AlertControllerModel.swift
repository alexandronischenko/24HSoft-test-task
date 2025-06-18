//
//  AlertControllerModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit.UIAlertController

struct AlertControllerModel {
    let title: String?
    let description: String?
    let items: [AlertControllerItemModel]
}

struct AlertControllerItemModel {
    let title: String
    let style: UIAlertAction.Style
}
