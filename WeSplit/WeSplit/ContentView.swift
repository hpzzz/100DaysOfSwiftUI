//
//  ContentView.swift
//  WeSplit
//
//  Created by Karol Harasim on 19/10/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numberOfPeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .foregroundColor(tipPercentage == 4 ? Color.red: Color.primary)
                    
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach( 2 ..< 100) {
//                            Text("\($0) people")
//                        }
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("How much tip do you want do leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount")) {
                    Text("$\(checkAmount)")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
