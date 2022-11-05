//
//  AddView.swift
//  iExpense
//


import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @ObservedObject var bizExpenses: BusinessExpenses
    
    @Environment(\.dismiss) var dismiss
    
    
    //MARK: Expenses Properties
    
    @State var name = ""
    @State var type = "Personal"
    @State var amount = 0.0
    
    
    //MARK: Amount Styling
    
    @State var amountStyle1 = false
    @State var amountStyle2 = false
    @State var amountStyle3 = false
    
    var amountStyling:Bool {
        
        var style = false
        
        if amount >= 10.00 && amount < 100 {
            style = true
        }
        else {
            style = false
        }
        return style
        
    }
    
    var amountStyling_2: Bool {
        var style = false
        if amount >= 100.00 && amount < 1000 {
            style = true
        }
        return style
    }
    
    var amountStyling_3: Bool {
        var style = false
        if amount >= 1000.00 {
            style = true
        }
        return style
    }
    
    
        
   let types = ["Personal", "Business"]

    
    
    var body: some View {
        NavigationStack {
            
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id:\.self) {
                        items in
                        Text(items)
                    }
                }.pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).foregroundColor(amountStyling ? .black : amountStyling_2 ? .white : amountStyling_3 ? .white : .white).padding().background(amountStyling ? .green : amountStyling_2 ? .purple : amountStyling_3 ? .red : .gray).cornerRadius(7)
            }
            .toolbar {
                Button{
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    let item = ExpenseItem(name: name, type: typeDepict(typeSelection: types), amount: amount)
                    
                    if type.contains("Personal") {
                        expenses.personalExpenses.append(item)
                    }
                    else {
                        bizExpenses.businessExpenses.append(item)
                    }
                    
                    dismiss()
                } label: {
                    Text("Save")
                }
            
            }
            
            
        }.navigationTitle("Add Expense")
  
    }
    
    func typeDepict(typeSelection: [String]) -> String {
        var selected = ""
        
        if type == "Personal" {
            selected = typeSelection[0]
        
        } else {
            selected = typeSelection[1]
        }
        
        return selected
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView(expenses: Expenses(), bizExpenses: BusinessExpenses())
        }
    }
}
