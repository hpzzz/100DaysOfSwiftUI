//
//  QuestionView.swift
//  MultiplicationTable
//
//  Created by Karol Harasim on 01/03/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    var numerek: Int
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            Text("\(numerek)")
    }
}
}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(numerek: 0)
//    }
//}
