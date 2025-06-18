//
//  MainViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    var onShowAlert: ((AlertControllerModel) -> Void)?
    var sectionViewModels: [any SectionViewModel] = []
    var didLoadData: (() -> Void)?

    private let mapper = MainMapper()
    private let networkManager = NetworkService()
    private let coordinator: MainFlow

    private var photos: [PhotoModel] = []

    init(coordinator: MainFlow, mapper: MainMapperProtocol = MainMapper(), networkManager: MainNetworkServiceProtocol = NetworkService()) {
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        loadData()
    }

    func loadData(isRefresh: Bool = false) {
        networkManager.fetchPhotos(
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let photos):
                    self.photos = photos
                    self.sectionViewModels = mapper.createSections(
                        delegate: self,
                        photos: self.photos
                    )
                    didLoadData?()
                case .failure(let error):
                    onShowAlert?(mapper.createAlertController(with: error))
                    didLoadData?()
                }
            }
        )
    }
}

extension MainViewModel: MainMapperDelegate {
    func didTapCell(photo: PhotoModel) {
        coordinator.goToPhoto(photo: photo)
    }
}
