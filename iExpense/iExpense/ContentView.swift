//
//  ContentView.swift
//  iExpense
//
//  Created by Павел Кай on 29.05.2022.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

var currency: FloatingPointFormatStyle<Double>.Currency {
    return .currency(code: Locale.current.currencyCode ?? "USD")
}



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(types, id: \.self) { section in
                    Section(header: Text(section)) {
                        ForEach(expenses.items.filter {$0.type == section}) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                Text(item.amount, format: currency)
                                    .foregroundColor(getColor(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeItems)
                        }
                    }
                    
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    
    func getColor(amount: Double) -> Color {
        if amount < 10 {
            return Color(.green)
        } else if amount < 100 {
           return Color(.yellow)
        } else {
           return Color(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
