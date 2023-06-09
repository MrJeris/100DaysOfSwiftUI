//
//  CachedUser+CoreDataProperties.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: NSSet?
    @NSManaged public var tags: NSSet?

    var wrappedId: String {
        id ?? ""
    }
    
    var wrappedName: String {
        name ?? ""
    }
    
    var wrappedAge: Int {
        Int(age)
    }
    
    var wrappedCompany: String {
        company ?? ""
    }
    
    var wrappedEmail: String {
        email ?? ""
    }
    
    var wrappedAddress: String {
        address ?? ""
    }
    
    var wrappedAbout: String {
        about ?? ""
    }
    
    var wrappedRegistered: String {
        guard let registeredDate = registered else {
            return ""
        }
        
        return registeredDate.formatted(date: .abbreviated, time: .shortened)
    }
    
    var tagsArray: [CachedTag] {
        let set = tags as? Set<CachedTag> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension CachedUser {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: CachedTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: CachedTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
