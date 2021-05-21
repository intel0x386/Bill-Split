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
	@State var showSaveAlert = false
	
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
					
					PersonRow(record: $billRecord)
					CheckAmountRow(checkAmount: $billRecord.checkAmount)
					TipPercentRow(record: $billRecord)
					TotalRow(record: $billRecord)
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
						
						showSaveAlert = true
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
			.alert(isPresented: $showSaveAlert) {
				Alert(title: Text("Check Details Saved!"), message: Text("Browse the past checks by clicking the Previous Bills button"), dismissButton: .default(Text("Okay")))
			}
		} // Navigation View ends
		
	}
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
		Group {
			ContentView()
				.environmentObject(BillRecords())
			ContentView()
				.preferredColorScheme(.dark)
				.environmentObject(BillRecords())
		}
				
   }
}



