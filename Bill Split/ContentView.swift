//
//  ContentView.swift
//  Bill Split
//
//  Created by Ankit Shah on 4/3/21.
//

import SwiftUI
import UserNotifications


struct ContentView: View {

    init() {
        print("ContentView created")
    }

    @State private var checkAmount = ""
    @State private var selectedPercentage = 2
    @State private var numberOfPeople = 2
    @State private var customPercentage = false
    @State private var expandPercentSection = false
    
    let tipPercentages = [5, 10, 20, 50, 75]

    var body: some View {
        print("Computing body property \(numberOfPeople)")
        return NavigationView {
            Form {
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach (2 ..< 100) {
                        Text("\($0) people")
                    }
                }
                
                Section(header: Text("Select Tip Percentage")) {
                    if expandPercentSection {
                        
                        if customPercentage {
                            Button(action: {
                                selectedPercentage = 2
                                customPercentage = false
                            }, label: {
                                Text("Choose Common Tips")
                                    .kerning(1)
                            })
                                .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .font(.body)
                        } else {
                            Picker("Select Tip Percentage", selection: $selectedPercentage) {
                                ForEach (0 ..< tipPercentages.count) {
                                    Text("\(tipPercentages[$0])%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Text("- or -")
                            .kerning(1)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                        
                        if customPercentage {
                            Picker("Select Tip Percentage", selection: $selectedPercentage) {
                                ForEach ( 0 ..< 100 ) {
                                    Text("\($0)%")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        } else {
                            Button(action: {
                                print("Button Pressed")
                                selectedPercentage = 15
                                customPercentage = true
                            }, label: {
                                Text("Select different Tip")
                                    .kerning(1)
                            })
                            .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.body)
                        }
                    
                    } else {
                        
                        Text("Selected Tip: \(selectedPercentage)%")
                        
                    }
                    
                }
            
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func validateText(text: inout String) -> String {
        var str = ""
        for cha in text {
            if cha.isNumber {
                str.append("\(cha)")
            }
        }
        text = str
        return text
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
