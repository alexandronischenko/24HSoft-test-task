//
//  Coordinator.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import UIKit.UINavigationController

protocol Coordinator: AnyObject {
    
    var id: UUID { get }
    var children: [UUID: Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    var onFinishFlow: (() -> Void)? { get set }
    
    func start()
}
