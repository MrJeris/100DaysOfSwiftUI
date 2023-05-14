//
//  CachedTag+CoreDataProperties.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//
//

import Foundation
import CoreData


extension CachedTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedTag> {
        return NSFetchRequest<CachedTag>(entityName: "CachedTag")
    }

    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?
    
    var wrappedName: String {
        name ?? ""
    }
}

// MARK: Generated accessors for users
extension CachedTag {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: CachedUser)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: CachedUser)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension CachedTag : Identifiable {

}
