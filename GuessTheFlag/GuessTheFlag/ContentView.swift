//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Karol Harasim on 25/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}


struct FlagImage: View {
    var number: Int
    var countries: [String]
    var body: some View {
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var animate = false
    @State private var rotationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var wrongAnswerAmount = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(Color.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.opacityAmount = 0.8
                    })
                    {
                        FlagImage(number: number, countries: self.countries)
                    }
                    .modifier(number != self.correctAnswer ? Shake(animatableData: CGFloat(self.wrongAnswerAmount)) : Shake(animatableData: CGFloat(0)))
                        .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotationAmount : 0), axis: (x: 0, y: 1, z: 0))
//                    .modifier(number == self.correctAnswer ? Shake(animatableData: CGFloat(0))) : Shake(animatableData: CGFloat(3))))

                    
                }
                Text("Total score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.rotationAmount += 360
            }
        } else {
            scoreTitle = "Wrong!\nThat's the flag of \(countries[number])"
            score -= 1
            withAnimation {
                self.wrongAnswerAmount += 1
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        self.opacityAmount = 1
        self.rotationAmount = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
