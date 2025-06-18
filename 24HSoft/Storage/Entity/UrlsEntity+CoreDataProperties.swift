//
//  UrlsEntity+CoreDataProperties.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 18.06.2025.
//
//

import Foundation
import CoreData


extension UrlsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UrlsEntity> {
        return NSFetchRequest<UrlsEntity>(entityName: "UrlsEntity")
    }

    @NSManaged public var regular: String?
    @NSManaged public var thumb: String?

}

extension UrlsEntity : Identifiable {

}
