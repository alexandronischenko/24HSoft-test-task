//
//  PhotoEntity+CoreDataProperties.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 18.06.2025.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var altDescription: String?
    @NSManaged public var color: String?
    @NSManaged public var id: String?
    @NSManaged public var likes: Int64
    @NSManaged public var photoDescription: String?
    @NSManaged public var urls: UrlsEntity?
    @NSManaged public var user: UserEntity?

}

extension PhotoEntity : Identifiable {

}
