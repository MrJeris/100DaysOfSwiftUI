//
//  FriendFace.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import SwiftUI

struct FriendFace: View {
    @Environment(\.managedObjectContext) var moc
    private var friendFaceManager = FriendFaceManager()
    
    @FetchRequest private var fetchRequest: FetchedResults<CachedUser>
    
    init() {
        _fetchRequest = FetchRequest<CachedUser>(sortDescriptors: [])
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { user in
            NavigationLink {
                FriendFaceDetailView(friendId: user.wrappedId)
            } label: {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                            .font(.title3)
                        Text("\(user.wrappedEmail)")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Text(user.isActive ? "Online" : "Offline")
                }
            }
        }
        .task {
            await friendFaceManager.loadData(moc: moc)
        }
        .listStyle(.plain)
        .navigationTitle("FriendFace")
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//struct FriendFace_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FriendFace()
//        }
//    }
//}
