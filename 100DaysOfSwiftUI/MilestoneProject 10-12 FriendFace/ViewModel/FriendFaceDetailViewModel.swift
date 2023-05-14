//
//  FriendFaceDetailViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//

import Foundation

class FriendFaceDetailViewModel: ObservableObject {
    
    func friendDetail(friend: FriendModel, of list: [UserModel]) -> UserModel? {
        if let user = list.first(where: {$0.id == friend.id && $0.name == friend.name}) {
            return user
        }
        return nil
    }
}
