//
//  FriendFaceManager.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//

import CoreData
import SwiftUI

struct FriendFaceManager {
    let dataURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func loadData(moc: NSManagedObjectContext) async {
        guard let url = URL(string: dataURL) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedResponse = try decoder.decode([UserModel].self, from: data)
            
            await MainActor.run(body: {
                databaseUpdate(moc: moc, users: decodedResponse)
            })
            
        } catch {
            print("Invalid data")
        }
    }
    
    func databaseUpdate(moc: NSManagedObjectContext, users: [UserModel]) {
        var tags = [String: CachedTag]()
        var friends = [String: CachedFriend]()
        
        for user in users {
            let newUser = CachedUser(context: moc)
            newUser.id = user.id
            newUser.age = Int16(user.age)
            newUser.name = user.name
            newUser.company = user.company
            newUser.email = user.email
            newUser.registered = user.registered
            newUser.about = user.about
            newUser.address = user.address
            newUser.isActive = user.isActive
            
            for tag in user.tags {
                if let existingTag = tags[tag] {
                    newUser.addToTags(existingTag)
                } else {
                    let newTag = CachedTag(context: moc)
                    newTag.name = tag
                    tags[tag] = newTag
                    
                    newUser.addToTags(newTag)
                }
            }
            
            for friend in user.friends {
                if let existingFriend = friends[friend.id] {
                    newUser.addToFriends(existingFriend)
                } else {
                    let newFriend = CachedFriend(context: moc)
                    newFriend.id = friend.id
                    newFriend.name = friend.name
                    friends[friend.id] = newFriend
                    
                    newUser.addToFriends(newFriend)
                }
            }
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
}
