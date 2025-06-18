//
//  UserEntity+CoreDataProperties.swift
//  24HSoft
//
//  Created by Alexandr Onischenko on 18.06.2025.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var username: String?

}

extension UserEntity : Identifiable {

}
