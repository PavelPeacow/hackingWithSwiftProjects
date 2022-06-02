//
//  ListView.swift
//  Moonshot
//
//  Created by Павел Кай on 02.06.2022.
//

import SwiftUI

struct ListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    @Binding var isList: Bool
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(missions) { mission in
                        LazyVStack {
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                                    
                            } label: {
                                HStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackgroung)
                                }
                        }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackgroung)
                        )
                    
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackgroung)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isList.toggle()
                    } label: {
                        Text("Switch to grid")
                    }
                }
            }
        }
        
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(isList: isList)
//    }
//}
