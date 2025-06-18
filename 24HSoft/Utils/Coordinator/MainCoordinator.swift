//
//  MainCoordinator.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: MainFlow {
    func goToPhoto(photo: PhotoModel) {
        let vc = PhotoViewController(viewModel: PhotoViewModel(username: photo.user?.username, photoUrl: photo.urls?.regular ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
}
