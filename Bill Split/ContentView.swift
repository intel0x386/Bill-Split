//
//  ContentView.swift
//  Bill Split
//
//  Created by Ankit Shah on 4/3/21.
//

import SwiftUI


struct ContentView: View {
   
   init() {
      print("ContentView created")
      //UITableView.appearance().backgroundColor = UIColor(red: 0.996, green: 0.553, blue: 0.552, alpha: 1)
      UITableView.appearance().backgroundColor = UIColor(red: 0.04, green: 0.239, blue: 0.137, alpha: 1)
   }
   
   @State private var checkAmount = "100"
   
   @State private var numberOfPeople = "2"
   
   @State private var tipPercent = "20"
   @State private var tipAmount = "50"
   
   @State private var percentOverAmount = true
   

   
   var body: some View {
      print("Computing body property Number of poeple \(numberOfPeople)")
      
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      let currencyUnit = formatter.locale.currencySymbol ?? ""
      
      var checkAmountD: Double {
         get {
            return Double(checkAmount) ?? 0.0
         }
      }
      
      var totalTip: Double {
         get {
            
            if percentOverAmount {
               return (Double(tipPercent) ?? 0.0) * checkAmountD / 100
            } else {
               return Double(tipAmount) ?? 0.0
            }
         }
      }
      
      var checkAmountPlusTip: Double {
         get {
            return totalTip + checkAmountD
         }
      }
      
      var totalPeople: Double {
         get {
            return Double(Int(numberOfPeople) ?? 0)
         }
      }
      
      
      let amountTextField = TextField("100 \(currencyUnit)", text: $checkAmount)
         .frame(width: 100, height: 32, alignment: .center)
         .multilineTextAlignment(.center)
         .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
         .cornerRadius(5)
         .font(.body)
         .keyboardType(.decimalPad)
      
      let bgColor = Color(red: 0.08, green: 0.392, blue: 0.224)
      
      return NavigationView {
         
         
         Form {
            
            Section {
               
               HStack {
                  Group {
                     Text("Check Amount")
                     Spacer()
                  } .onTapGesture { hideKeyboard() }
                  amountTextField
                  Text("\(currencyUnit)")
                     .frame(width: 20)
                     .onTapGesture { hideKeyboard() }
               }
               //.listRowBackground(Color(red: 0.992, green: 0.369, blue: 0.325))
               
               
               HStack {
                  Group {
                     Text("Number Of People")
                     Spacer()
                  } .onTapGesture { hideKeyboard() }
                  
                  TextField("4", text: $numberOfPeople)
                     .frame(width: 100, height: 32, alignment: .center)
                     .multilineTextAlignment(.center)
                     .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
                     .cornerRadius(5)
                     .font(.body)
                     .keyboardType(.numberPad)
                  Text("")
                     .frame(width: 20)
                     .onTapGesture { hideKeyboard() }
               }
               
            } // Amount Section ends here
            .listRowBackground(bgColor)
            .foregroundColor(.white)
            
            Section(header: Text("How much Tip do you want to leave?")) {

               HStack {
                  
                  Group {
                     Text("Tip Percent")
                     Spacer()
                  } .onTapGesture { hideKeyboard() }
                  
                  TextField("20", text: $tipPercent, onEditingChanged: { (editing) in
                     if editing {
                        percentOverAmount = true
                     }
                  })
                     .frame(width: 100, height: 32, alignment: .center)
                     .multilineTextAlignment(.center)
                     .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
                     .cornerRadius(5)
                     .font(.body)
                     .keyboardType(.numberPad)
                  Text("%")
                     .frame(width: 20)
                     .onTapGesture { hideKeyboard() }
               }
                  .foregroundColor(percentOverAmount ? Color.white : Color.gray)
                  
               Text("- or -")
                  .frame(maxWidth: .infinity)
                  .contentShape(Rectangle())
                  .foregroundColor(.gray)
                  .onTapGesture { hideKeyboard() }
               
               HStack {
                  
                  Group {
                     Text("Tip Amount")
                     Group {
                        Spacer()
                           .contentShape(Rectangle())
                     }
                        .onTapGesture { hideKeyboard() }
                  } .onTapGesture { hideKeyboard() }
                  
                  TextField("20", text: $tipAmount, onEditingChanged: { (editing) in
                     if editing {
                        percentOverAmount = false
                        
                     }
                  })
                     .frame(width: 100, height: 32, alignment: .center)
                     .multilineTextAlignment(.center)
                     .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
                     .cornerRadius(5)
                     .font(.body)
                     .keyboardType(.decimalPad)
                  Text("\(currencyUnit)")
                     .frame(width: 20)
                     .onTapGesture { hideKeyboard() }
               }
                  .foregroundColor(percentOverAmount ? Color.gray : Color.white)
                  
            } // Tip Section Ends Here
            .listRowBackground(bgColor)
            .foregroundColor(.white)
            
            
            Section(header: Text("Amount per person:")) {
               
               HStack {
                  Text("Amount per person")
                  Spacer()
                  Text("\(checkAmountPlusTip / totalPeople, specifier: "%g")")
                  Text(currencyUnit)
                     .frame(width: 20)
               }
                  .foregroundColor(.black)
                  .font(.title2)
               .listRowBackground(Color(red: 0.16, green: 0.843, blue: 0.486))
               
               
               /*
               HStack {
                  Text("Total Amount")
                  Spacer()
                  Text("\(Double(checkAmount) ?? 0.0, specifier: "%g")")
                  Text(currencyUnit)
                     .frame(width: 20)
               }
               
               HStack {
                  Text("Total Tip")
                  Spacer()
                  Text("\(totalTip, specifier: "%g")")
                  Text(currencyUnit)
                     .frame(width: 20)
               }
               
               HStack {
                  Text("Check + Tip")
                  Spacer()
                  Text("\(checkAmountPlusTip, specifier: "%g")")
                  Text(currencyUnit)
                     .frame(width: 20)
               }
               */
               
               
               HStack {
                  Group {
                     Text("\(checkAmountPlusTip, specifier: "%g")")
                     Text(currencyUnit)
                     Spacer()
                  }
                  Group {
                     Text("/")
                     Spacer()
                     Text("\(totalPeople, specifier: "%g")")
                     Text("People")
                        .font(.subheadline)
                     Spacer()
                  }
                  Group {
                     Text("=")
                     Spacer()
                     Text("\(checkAmountPlusTip / totalPeople, specifier: "%g")")
                     Text("\(currencyUnit) / Person")
                  }
               }
               
            }
            .listRowBackground(bgColor)
            
            .contentShape(Rectangle())
            .padding(0)
            .onTapGesture {
               hideKeyboard()
            }
            .foregroundColor(Color.gray)
            .foregroundColor(.white)
         } // End of Form
         
         .navigationBarTitleDisplayMode(.inline)
         .navigationTitle("Check Split")
         
      } // End of Navigation View
      
   }
   
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
   
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}


