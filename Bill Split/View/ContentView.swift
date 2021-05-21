//
//  ContentView.swift
//  Bill Split
//
//  Created by Ankit Shah on 4/3/21.
//

import SwiftUI


struct ContentView: View {
	@EnvironmentObject var allRecords: BillRecords
	@State var billRecord = BillRecord(persons: 0, tipPercent: 15, checkAmount: "")
	@State var showPreviousBillSheet = false
	@Environment(\.presentationMode) var pMode
	
	var body: some View {
		NavigationView {
			
			ZStack(alignment: .top) {
				
				VStack {
					Color("backgroundColor")
				}
				.onTapGesture {
					print("Dismissing Keyboard")
					hideKeyboard()
				}
				
				VStack(spacing: 20) {
					
					PersonRow(persons: $billRecord.persons)
					CheckAmountRow(checkAmount: $billRecord.checkAmount)
					TipPercentRow(tipPercent: $billRecord.tipPercent)
					TotalRow(persons: $billRecord.persons, checkAmount: $billRecord.checkAmount, tipPercent: $billRecord.tipPercent)
				}
				.padding()
				.background(Color("backgroundColor"))
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("Bill Split")
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						billRecord.date = Date()
						allRecords.storeRecord(record: billRecord)
					}, label: {
						Text("Save")
					})
				}
				
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						showPreviousBillSheet = true
					}, label: {
						Text("Previous Bills")
					})
				}
				
			} // toolbar ends
			.sheet(isPresented: $showPreviousBillSheet, content: {
				PreviousBillSheet()
			})
		} // Navigation View ends
		
	}
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
				.environmentObject(BillRecords())
   }
}



