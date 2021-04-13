//
//  ContentView.swift
//  Bill Split
//
//  Created by Ankit Shah on 4/3/21.
//

import SwiftUI


struct InputField: ViewModifier {
   func body(content: Content) -> some View {
      content
         .frame(width: 100, height: 32, alignment: .center)
         .multilineTextAlignment(.center)
         .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
         .cornerRadius(5)
         .font(.body)
         .keyboardType(.decimalPad)
   }
}


struct PostFixText: View {
   var text: String
   
   var body: some View {
      Text(text)
         .frame(width: 20)
         .onTapGesture { hideKeyboard() }
   }
}


struct TextAndSpacer: View {
   var text: String
   
   var body: some View {
      HStack {
         Text(text)
            .font(.system(.body, design: .rounded))
            .fontWeight(.light)
            .kerning(1)
         Spacer()
      }
         .contentShape(Rectangle())
         .onTapGesture { hideKeyboard() }
   }
}


struct ContentView: View {
   
   init() {
      print("ContentView created")
      
      //UITableView.appearance().backgroundColor = UIColor(red: 0, green: 0.502, blue: 1, alpha: 1)
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
      
      
      let bgColor =  Color.white //Color(red: 0, green: 0.753, blue: 1)
      let fgColor = Color.black
      let fgColor2 = Color(red: 0, green: 0, blue: 0, opacity: 0.25)
      
      return NavigationView {
         
         Form {
            Section {
               HStack {
                  TextAndSpacer(text: "Check Amount")
                  TextField("100 \(currencyUnit)", text: $checkAmount)
                     .modifier(InputField())
                  PostFixText(text: "\(currencyUnit)")
               }
               HStack {
                  TextAndSpacer(text: "Number Of People")
                  TextField("4", text: $numberOfPeople)
                     .modifier(InputField())
                  PostFixText(text: "")
               }
            } // Amount Section ends here
               .listRowBackground(bgColor)
               .foregroundColor(fgColor)
            
            Section(header: Text("How much Tip do you want to leave?").foregroundColor(.white)) {
               HStack {
                  TextAndSpacer(text: "Tip Percent")
                  TextField("20", text: $tipPercent, onEditingChanged: { (editing) in
                     if editing {
                        percentOverAmount = true
                  }})
                     .modifier(InputField())
                  PostFixText(text: "%")
               }
                  .foregroundColor(percentOverAmount ? Color.black : fgColor2)

               Text("- or -")
                  .frame(maxWidth: .infinity)
                  .contentShape(Rectangle())
                  .foregroundColor(.gray)
                  .onTapGesture { hideKeyboard() }
               
               HStack {
                  TextAndSpacer(text: "Tip Amount")
                  TextField("20", text: $tipAmount, onEditingChanged: { (editing) in
                     if editing {
                        percentOverAmount = false
                  }})
                     .modifier(InputField())
                  PostFixText(text: "\(currencyUnit)")
               }
                  .foregroundColor(percentOverAmount ? fgColor2 : Color.black)
            } // Tip Section Ends Here
               .listRowBackground(bgColor)
               .foregroundColor(fgColor)
            
            
            Section(header: Text("Amount per person:").foregroundColor(.white)) {
               // MARK: MAIN DISPLAY ROW - AMOUNT PER PERSON
               HStack {
                  //TextAndSpacer(text: "Amount per person")
                  Text("Per Person")
                     .font(.title)
                  Spacer()
                  Text("\(checkAmountPlusTip / totalPeople, specifier: "%g")")
                  PostFixText(text: currencyUnit)
               }
                  .foregroundColor(.black)
                  .font(.title)
                  .listRowBackground(bgColor)
               
               
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
               } // Last Row
               .listRowBackground(bgColor)
               .foregroundColor(Color.gray)
            }
            .foregroundColor(fgColor)
         } // End of Form
         .onAppear(perform: {
            UITableView.appearance().separatorStyle = .none
            print("View Appeared")
         })
         .navigationBarTitleDisplayMode(.inline)
         .navigationTitle("Check Split")
         .navigationBarItems(trailing: Button("Dismiss", action: {
            hideKeyboard()
         }))
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


