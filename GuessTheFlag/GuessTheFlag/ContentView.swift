//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Павел Кай on 09.05.2022.
//

import SwiftUI

struct FlagImage: View {
    var numberImage: Int
    var arrayImage: [String]
    var correctAnimation: Bool
    var wrongAnimation: Bool
    var correctAnswer: Int
    var numberOfFlag: Int
    
    var body: some View {
        Image(arrayImage[numberImage])
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(correctAnimation && correctAnswer == numberOfFlag
                            ? .green : .black, lineWidth: 5)
            )
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(correctAnimation && correctAnswer == numberOfFlag ? 360 : 0),
                axis: (x: 0, y: 1, z: 0))
            .opacity(correctAnimation && correctAnswer != numberOfFlag ? 0.25 : 1)
            .opacity(wrongAnimation && correctAnswer != numberOfFlag ? 0.25 : 1)
            .scaleEffect(correctAnimation && correctAnswer != numberOfFlag ? 0.7 : 1)
            .scaleEffect(wrongAnimation && correctAnswer != numberOfFlag ? 0.7 : 1)
            
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var times = 0
    @State private var showingFinal = false
    @State private var finalTitle = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correctAnimation = false
    @State private var wrongAnimation = false
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(numberImage: number,
                                      arrayImage: countries,
                                      correctAnimation: correctAnimation,
                                      wrongAnimation: wrongAnimation,
                                      correctAnswer: correctAnswer,
                                      numberOfFlag: number)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                if correctAnimation {
                    correctAnimation.toggle()
                }
                if wrongAnimation {
                    wrongAnimation.toggle()
                }
                askQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(finalTitle, isPresented: $showingFinal) {
            Button("Reset game") {
                if correctAnimation {
                    correctAnimation.toggle()
                }
                if wrongAnimation {
                    wrongAnimation.toggle()
                }
                reset()
            }
        } message: {
            Text("Final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            withAnimation {
                correctAnimation.toggle()
            }
        } else {
            scoreTitle = "Wrong! That's flag of \(countries[number])"
            score -= 1
            
            withAnimation {
                wrongAnimation.toggle()
            }
        }
        
        times += 1
        if times == 8 {
            showingFinal = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        times = 0
        score = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
