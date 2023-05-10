//
//  FriendFace.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import SwiftUI

struct FriendFace: View {
    @State private var users = [UserModel]()
    
    var body: some View {
        List(users, id: \.id) { user in
            NavigationLink {
                FriendFaceDetailView(users: users, user: user)
            } label: {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title3)
                        Text("\(user.email)")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Text(user.isActive ? "Online" : "Offline")
                }
            }
        }
        .listStyle(.plain)
        .task {
            await loadData()
        }
        .navigationTitle("FriendFace")
        .navigationBarTitleDisplayMode(.inline)
    }
    
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

struct FriendFace_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FriendFace()
        }
    }
}
