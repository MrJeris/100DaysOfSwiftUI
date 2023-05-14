//
//  FriendFaceViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import Foundation
import SwiftUI

class FriendFaceViewModel: ObservableObject {
    let dataURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func loadData() async {
        guard let url = URL(string: dataURL) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            JSONDecoder().dateDecodingStrategy = .iso8601
            
            let decodedUser = try JSONDecoder().decode([UserModel].self, from: data)
        } catch {
            fatalError("")
        }
    }
}
