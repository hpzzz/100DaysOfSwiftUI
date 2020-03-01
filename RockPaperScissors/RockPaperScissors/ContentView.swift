//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Karol Harasim on 25/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI


struct appMoveImage: View {
    var move: String
    var shouldWin: Bool
    var body: some View {
        VStack {
            Text("App picks:")
                .font(.title)
            Image(move)
            .resizable()
                .frame(width: 100, height: 100)
            Text("You ought to \(shouldWin ? "win": "lose")")
        }
    }
}

struct moveImage: View {
    var move: String
    var body: some View {
        Image(move)
        .resizable()
            .frame(width: 100, height: 100)
    }
}

struct ContentView: View {
    private var moves = ["rock", "paper", "scissors"]
    @State private var shouldPlayerWin = Bool.random()
    @State private var score = 0
    @State private var appChoice = Int.random(in: 0 ... 2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("Your score: \(score)")
                    .font(.largeTitle)
                appMoveImage(move: moves[appChoice], shouldWin: shouldPlayerWin)
                HStack(spacing: 20) {
                    ForEach( 0 ..< moves.count) { number in

                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            moveImage(move: self.moves[number])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is: \(score)"), dismissButton: .default(Text("Continue")) {
                    self.nextRound()
                    })
            }
        }
    }
    
    func buttonTapped(_ number: Int) {
        switch (appChoice, number) {
        case (0, 2), (1,0), (2,1):
            if shouldPlayerWin {
                score -= 1
                scoreTitle = "Wrong"
            } else {
                score += 1
                scoreTitle = "Correct"
            }
            
        case (2, 0), (0, 1), (1, 2):
            if !shouldPlayerWin {
                score -= 1
                scoreTitle = "Wrong"
            } else {
                score += 1
                scoreTitle = "Correct"
            }
        case (0, 0), (1, 1), (2, 2):
            score -= 1
            scoreTitle = "Wrong, you were supposed to \(shouldPlayerWin ? "win" : "lose"), not tie!"
        default:
            print("")
        }
        showingScore = true
    }
    
    func nextRound() {
        appChoice = Int.random(in: 0 ... 2)
        shouldPlayerWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
