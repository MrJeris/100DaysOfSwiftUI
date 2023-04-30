//
//  GuessTheFlag.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 30.04.2023.
//

import SwiftUI

struct GuessTheFlag: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCounter = 0
    
    @State private var selectedFlag = -1
    @State private var rotationFlag = 0.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .fontWeight(.heavy)
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .animation(.default, value: correctAnswer)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1: 0.8)
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .animation(.default, value: selectedFlag)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCounter != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart game", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Your score is \(score)")
            } else {
                Text("You ended the game with a score of \(score). Press restart to restart the game.")
            }
        }
        .navigationTitle("Guess The Flag")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            if score > 0 {
                score -= 1
            }
            scoreTitle = "Wrong it's flag \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        selectedFlag = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func restartGame() {
        selectedFlag = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 1
        score = 0
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
