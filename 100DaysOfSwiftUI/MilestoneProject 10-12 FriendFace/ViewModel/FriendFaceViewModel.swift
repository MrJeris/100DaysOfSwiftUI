//
//  FriendFaceViewModel.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 12.05.2023.
//

import Foundation

class FriendFaceViewModel: ObservableObject {
    @Published var users = [UserModel]()
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([UserModel].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}
