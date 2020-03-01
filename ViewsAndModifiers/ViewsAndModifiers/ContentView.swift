//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Karol Harasim on 25/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct CapsuleView: View {
    var text: String
    var body: some View {
        Text(text)
        .padding()
            .foregroundColor(.white)
            .background(Color.blue)
        .clipShape(Capsule())
    }
}

struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                Text(text)
                .font(.caption)
                .foregroundColor(.white)
            .padding()
                .background(Color.black)
        }
        
    }
}

extension View {
    func Watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
        .padding()
            .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
extension View {
    func largeBlueFontStyle() -> some View {
        self.modifier(LargeBlueFont())
    }
}
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body: some View {
        VStack {
            ForEach(0 ..< rows) {row in
                HStack {
                    ForEach(0 ..< self.columns) {column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping(Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(rows: 3, columns: 3) { row, col in
                Image(systemName: "\(row * 3 + col).circle")
                Text("R\(row) C\(col)")
            .largeBlueFontStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
