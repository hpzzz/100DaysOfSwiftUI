//
//  ContentView.swift
//  iExpense
//
//  Created by Karol Harasim on 29/02/2020.
//  Copyright © 2020 Karol Harasim. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var type: String
    var amount: Int
}
class Expenses: ObservableObject {
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
}
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
                print("yes")
            }
        }
    }
}

struct ExpenseAmount: View {
    var amount: Int
    var body: some View {
        switch amount {
        case 0...10:
            return Text("$\(self.amount)")
        case 10...100:
            return Text("$\(self.amount)")
                .foregroundColor(.blue)
        default:
            return Text("$\(self.amount)")
                .foregroundColor(Color.red)
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
//                        Text("$\(item.amount)")
                        ExpenseAmount(amount: item.amount)
                    }
                }
            .onDelete(perform: removeItems)
            }
        .navigationBarTitle("iExpense")
                
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddExpense = true
            })
            {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }

        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
