//
//  SectionViewModel.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 17.06.2025.
//

import Foundation

protocol SectionViewModel {
    var sectionHeaderModel: SectionHeaderViewModel? { get set }
    var sectionFooterModel: SectionHeaderViewModel? { get set }
    var cellViewModels: [CellViewModel] { get set }
    var id: UUID { get }
}

struct DefaultSectionViewModel: SectionViewModel {
    var sectionHeaderModel: SectionHeaderViewModel? = nil
    var sectionFooterModel: SectionHeaderViewModel? = nil
    var cellViewModels: [CellViewModel] = []
    let id = UUID()
}
