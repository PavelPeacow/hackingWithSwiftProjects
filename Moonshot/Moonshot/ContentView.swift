//
//  ContentView.swift
//  Moonshot
//
//  Created by Павел Кай on 29.05.2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var isList = false

    var body: some View {
        Group {
            if isList {
                ListView(astronauts: astronauts, missions: missions, isList: $isList)
            } else {
                GridVIew(astronauts: astronauts, missions: missions, isList: $isList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
