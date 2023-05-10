//
//  FriendFaceDetailView.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 10.05.2023.
//

import SwiftUI
import WrappingHStack

struct FriendFaceDetailView: View {
    let users: [UserModel]
    let user: UserModel
    
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
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(user.isActive ? "Online" : "Offline")
                                .foregroundColor(user.isActive ? .blue : .gray)
                        }
                        Spacer()
                    }
                    
                    //About me
                    ScrollView(showsIndicators: false) {
                        Text(user.about)
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 10, alignment: .center)
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text(user.email)
                    }
                    
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                        Text(user.registered, style: .date)
                    }
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(user.address)
                    }
                    
                    HStack {
                        Image(systemName: "building.2")
                        Text(user.company)
                    }
                    
                    WrappingHStack(user.tags, id: \.self) {
                        Text("#\($0)")
                            .foregroundColor(.blue)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Friend List")
                        .font(.title)
                    
                    List(user.friends, id: \.id) { friend in
                        friendDetail(friend: friend, of: users).map { friendItem in
                            NavigationLink {
                                FriendFaceDetailView(users: users, user: friendItem)
                            } label: {
                                HStack {
                                    Image(systemName: "person.circle")
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading) {
                                        Text(friend.name)
                                            .font(.title3)
                                        Text("\(user.email)")
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(user.isActive ? "Online" : "Offline")
                                }
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
    
    func friendDetail(friend: FriendModel, of list: [UserModel]) -> UserModel? {
        if let user = list.first(where: {$0.id == friend.id && $0.name == friend.name}) {
            return user
        }
        return nil
    }
}

struct FriendFaceDetailView_Previews: PreviewProvider {
    static let user = UserModel(
        id: "2424fdfsf2-fefewf",
        isActive: false,
        name: "Alfrod Rodriguez",
        age: 21,
        company: "Imkan",
        email: "alfordrodrizuez@imkan.com",
        address: "907 Nelson Street, Cotopaxi, 5913",
        about: "Occaecat consequat elit fdsfsfsvcxvgfsfgsgnidsf'vndsfoliv;sfghjnesoil;ajfpvaesovthaspgjves'gas",
        registered: Date.now,
        tags: ["cillum", "consequat"],
        friends: [FriendModel(id: "925jeof324214fdfd-v1", name: "Hawkins Patel")]
    )
    
    static var previews: some View {
        FriendFaceDetailView(users: [user, user], user: user)
    }
}
