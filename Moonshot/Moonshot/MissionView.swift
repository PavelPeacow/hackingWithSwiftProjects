//
//  MissionView.swift
//  Moonshot
//
//  Created by Павел Кай on 30.05.2022.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                    
                    VStack {
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        
                        DividerView()
                        
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        DividerView()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                   ScrollViewForMissionView(mission: mission, astronauts: astronauts)
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackgroung)
        }
    }
}

//struct MissionView_Previews: PreviewProvider {
//    static let missions: [Mission] = Bundle.main.decode("missions.json")
//    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
//    
//    static var previews: some View {
//        MissionView(mission: missions[0])
//            .preferredColorScheme(.dark)
//    }
//}
