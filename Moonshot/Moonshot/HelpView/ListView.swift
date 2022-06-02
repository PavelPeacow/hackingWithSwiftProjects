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
                                .padding(.vertical, 48)
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
                .listRowBackground(Color.darkBackgroung)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Moonshot")
            .background(.darkBackgroung)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isList.toggle()
                    } label: {
                        Label("Switch to grid", systemImage: "rectangle.grid.2x2.fill")
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListView(astronauts: astronauts, missions: missions, isList: .constant(false))
    }
}
