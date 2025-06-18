//
//  BaseCoordinator.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit.UINavigationController

class BaseCoordinator: Coordinator {

    // MARK: - Coordinator

    let id = UUID()
    var children: [UUID: Coordinator] = [:]
    
    weak var navigationController: UINavigationController?
    
    var onFinishFlow: (() -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Instance Methods
    
    func start() {
        fatalError("BaseCoordinator's start() method must be overriden.")
    }
}
