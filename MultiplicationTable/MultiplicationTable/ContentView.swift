//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Karol Harasim on 29/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var slidein = false
    private var multiplications = [[1, 2], [3, 4], [5, 6], [7,8], [9,10], [11,12]]
    @State private var numerek = 0
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 50) {
                    Text("Choose table you want to practice")
                        .fontWeight(.heavy)
                        .font(.headline)
                        .foregroundColor(.white)
                    NavigationLink(destination: QuestionView(numerek: numerek), isActive: $slidein) {
                        EmptyView()
                    }
                    VStack(spacing: 20) {
                        ForEach(0 ..< 6) { row in
                            HStack {
                                ForEach(0 ..< 2, id: \.self) { column in
                                        Text("\(self.multiplications[row][column])x")
                                        .frame(width: 150, height: 75, alignment: .center)
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 50))
                                            .onTapGesture {
                                                self.numerek = self.multiplications[row][column]
                                                self.slidein = true
                                    }
                                    }
                                }
                            }
                    }
                        
                    }

                }
            }
        }
    func askQuestions(multiplier: Int) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
