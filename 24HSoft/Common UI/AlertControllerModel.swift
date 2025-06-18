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

    static func createErrorAlertModel() -> AlertControllerModel {
        return .init(
            title: "Произошла ошибка, попробуйте позже",
            description: nil,
            items: [
            .init(title: "OK", style: .default)
        ])
    }
}

struct AlertControllerItemModel {
    let title: String
    let style: UIAlertAction.Style
}

extension UIAlertController {
    static func createAlertContoller(
        with model: AlertControllerModel
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: model.title,
            message: model.description,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: model.items.first?.title,
            style: .default
        )
        alert.addAction(action)
        return alert
    }
}
