//
//  MainProtocols.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

// MARK: - Flow

protocol MainFlow {
    func goToPhoto(photo: PhotoModel)
}

// MARK: - Mapper

protocol MainMapperDelegate: AnyObject {
    func didTapCell(photo: PhotoModel)
}

protocol MainMapperProtocol {
    func createSections(
        delegate: MainMapperDelegate,
        photos: [PhotoModel]
    ) -> [SectionViewModel]
    func createAlertController(with error: Error) -> AlertControllerModel
}

// MARK: - ViewModel

protocol MainViewModelProtocol {
    var sectionViewModels: [SectionViewModel] { get set }
    var didLoadData: (() -> Void)? { get set }
    var onShowAlert: ((AlertControllerModel) -> Void)? { get set }

    func viewDidLoad()
    func loadData(isRefresh: Bool)
}

// MARK: - NetworkService

protocol MainNetworkServiceProtocol {
    func fetchPhotos(isRefresh: Bool, completion: @escaping (Result<[PhotoModel], Error>) -> Void)
}
