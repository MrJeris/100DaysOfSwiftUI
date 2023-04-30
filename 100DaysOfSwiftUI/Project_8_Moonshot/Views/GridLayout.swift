//
//  GridLayout.swift
//  Moonshot
//
//  Created by MrJeris on 25.04.2023.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { misson in
                    NavigationLink {
                        MissionView(mission: misson, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(misson.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(misson.displayName)
                                    .font(.headline)
                                
                                Text(misson.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay (RoundedRectangle(cornerRadius: 10).stroke(.lightBackground, lineWidth: 4))
                    }
                }
            }
            .padding([.bottom, .horizontal])
        }
    }
}

struct GridLayout_Previews: PreviewProvider {
    static var previews: some View {
        GridLayout(astronauts: Bundle.main.decode("astronauts.json"), missions: Bundle.main.decode("missions.json"))
            .preferredColorScheme(.dark)
    }
}
