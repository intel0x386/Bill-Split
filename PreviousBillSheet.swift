//
//  PreviousBillSheet.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI

struct PreviousBillSheet: View {
	
	@EnvironmentObject var allRecords: BillRecords
	
	let dateFormatter: DateFormatter = {
		let dateF = DateFormatter()
		dateF.dateFormat = "yy-MM-dd"
		return dateF
	}()
	
	var body: some View {
		NavigationView {

			List {
				ListRow(date: "Date", checkAmount: "Check Amount")
					.font(.system(.title2, design: .monospaced))
					.padding(.vertical)
					
				ForEach (allRecords.records) {
					record in
					NavigationLink(
						destination: Text("Test"))
					{
					let date = dateFormatter.string(from: record.date)
							ListRow(date: date, checkAmount: record.checkAmount)
						}
				}
				
			}
			.padding(.all, 20)
			.navigationTitle("Previous Checks")
			.navigationBarTitleDisplayMode(.inline)
			.foregroundColor(Color.accentColor)
		}
	}
}

struct ListRow: View {
	var date: String
	var checkAmount: String
	var body: some View {
		HStack {
			Text(date)
			Spacer()
			Text(checkAmount)
			Text(SymbolsAndConstants.currencyUnit)
		}
	}
}


struct PreviousBillSheet_Previews: PreviewProvider {
	static var billR: BillRecords =
		{
			let b = BillRecords()
			b.records.append(BillRecord(persons: 0, tipPercent: 10, checkAmount: "900"))
			return b
		}()
	
	static var previews: some View {
		PreviousBillSheet()
			.environmentObject(billR)
	}
}
