//
//  FriendFaceDetailView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import SwiftUI
import WrappingHStack

struct FriendFaceDetailView: View {
    @FetchRequest var fetchRequest: FetchedResults<CachedUser>
    
    let friendId: String
    
    init(friendId: String) {
        self.friendId = friendId
        
        let predicate = NSPredicate(format: "id == %@", friendId)
        _fetchRequest = FetchRequest(sortDescriptors: [], predicate: predicate)
    }
    
    private var userDetail: CachedUser {
        return getUserDetail()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading, spacing: 14) {
                    //Image + Name
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading) {
                            Text(userDetail.wrappedName)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(userDetail.isActive ? "Online" : "Offline")
                                .foregroundColor(userDetail.isActive ? .blue : .gray)
                        }
                        Spacer()
                    }
                    
                    //About me
                    ScrollView(showsIndicators: false) {
                        Text(userDetail.wrappedAbout)
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .center)
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text(userDetail.wrappedEmail)
                    }
                    
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                        Text(userDetail.wrappedRegistered)
                    }
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(userDetail.wrappedAddress)
                    }
                    
                    HStack {
                        Image(systemName: "building.2")
                        Text(userDetail.wrappedCompany)
                    }
                    
                    WrappingHStack(userDetail.tagsArray, id: \.self) { tag in
                        Text("#\(tag.wrappedName)")
                            .foregroundColor(.blue)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Friend List")
                        .font(.title)
                    
                    List(userDetail.friendsArray, id: \.id) { friend in
                        NavigationLink {
                            FriendFaceDetailView(friendId: friend.wrappedId)
                        } label: {
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.largeTitle)
                                
                                Text(friend.wrappedName)
                                    .font(.title3)
                                
                                Spacer()
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
        }
        .background(Color(red: 251 / 255, green: 251 / 255, blue: 251 / 255))
    }
    
    func getUserDetail() -> CachedUser {
        if !fetchRequest.isEmpty {
            guard let user = fetchRequest.first else {
                return CachedUser()
            }
            
            return user
        } else {
            return CachedUser()
        }
    }
}
