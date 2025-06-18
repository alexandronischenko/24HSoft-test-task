//
//  MainMapper.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

struct MainMapper: MainMapperProtocol {
    func createSections(
        delegate: MainMapperDelegate,
        photos: [PhotoModel]
    ) -> [SectionViewModel] {
        var section = DefaultSectionViewModel()
        section.cellViewModels = photos.map { photo in
            CollectionViewCellViewModel(
                photoName: photo.urls?.thumb ?? "",
                description: photo.description ?? photo.altDescription ?? "",
                descriptionColorName: photo.color ?? "",
                likes: photo.likes ?? 0,
                actionBlock: { [weak delegate] in
                    delegate?.didTapCell(photo: photo)
                }
            )
        }
        return [section]
    }

    func createAlertController() -> AlertControllerModel {
        .createErrorAlertModel()
    }
}
