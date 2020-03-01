//
//  ContentView.swift
//  Animations
//
//  Created by Karol Harasim on 27/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
        .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
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

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var isShowingRed = false
    let letters = Array("Hello SwiftUI")
    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(self.letters[num]))
//                .padding(5)
//                    .font(.title)
//                    .background(self.enabled ? Color.blue: Color.red)
//                    .offset(self.dragAmount)
//                    .animation(Animation.default.delay(Double(num) / 20))
//            }
//        }
//    .gesture(
//        DragGesture()
//            .onChanged {self.dragAmount = $0.translation}
//            .onEnded { _ in
//                self.dragAmount = .zero
//                self.enabled.toggle()
//        }
//        )
        VStack {
Text("LuL")
                
        .modifier(Shake(animatableData: CGFloat(3)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
