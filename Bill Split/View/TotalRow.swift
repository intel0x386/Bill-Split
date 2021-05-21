//
//  TotalRow.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI

struct TotalRow: View {
	
	@Binding var record: BillRecord
	
	var body: some View {
		HStack {
			Text("Total Amount: ")
				.kerning(1)
				.font(.title3)
				.fontWeight(.bold)
			Spacer()
			NumberBox(text: record.amountPerPerson, frameWidth: 160)
			Text("\(SymbolsAndConstants.currencyUnit)")
				.font(.title)
				
		}
		.modifier(RowModifier())
		.foregroundColor(Color.accentColor)
	}
}

struct TotalRow_Previews: PreviewProvider {
	static var previews: some View {
		TotalRow(record: .constant(BillRecord(persons: 10, tipPercent: 20, checkAmount: "300000")))
	}
}
