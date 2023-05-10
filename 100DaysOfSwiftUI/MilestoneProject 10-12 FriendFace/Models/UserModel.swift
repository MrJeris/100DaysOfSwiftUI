//
//  UserModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import Foundation

struct UserModel: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [FriendModel]
}
