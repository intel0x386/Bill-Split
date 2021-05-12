//
//  TotalRow.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI

struct TotalRow: View {
	
	@Binding var persons: Int
	@Binding var checkAmount: String
	@Binding var tipPercent: Int
	
	var AmountPerPerson: String {
		get {
			let checkAmountDouble = Double(checkAmount) ?? 0
			let totalAmt: Double = checkAmountDouble + checkAmountDouble * Double(tipPercent) / 100
			let perPerson = totalAmt / Double((persons + 2))
			return String(format: "%.1f", perPerson)
		}
	}
	
	var body: some View {
		HStack {
			Text("Total Amount: ")
				.kerning(1)
				.font(.title3)
				.fontWeight(.bold)
			Spacer()
			NumberBox(text: AmountPerPerson, frameWidth: 160)
			Text("\(SymbolsAndConstants.currencyUnit)")
				.font(.title)
				
		}
		.modifier(RowModifier())
		.foregroundColor(Color.accentColor)
	}
}

struct TotalRow_Previews: PreviewProvider {
	static var previews: some View {
		TotalRow(persons: .constant(2), checkAmount: .constant("2900"), tipPercent: .constant(25))
	}
}
