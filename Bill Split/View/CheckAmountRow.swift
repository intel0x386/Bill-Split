//
//  CheckAmountRow.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI


struct CheckAmountRow: View {
	@Binding var checkAmount: String
	var body: some View {
		HStack {
			Text("Check Amount")
				.kerning(1)
			Spacer()
				TextField("Amount", text: $checkAmount)
					.frame(width: 150)
					.multilineTextAlignment(.center)
					.keyboardType(.decimalPad)
					.font(.title)
					.foregroundColor(.accentColor)
					.padding(.all, 5)
					.overlay(
						RoundedRectangle(cornerRadius: 6)
							.strokeBorder(Color.accentColor, lineWidth: 3)
					)
				Text("\(SymbolsAndConstants.currencyUnit)")
					.font(.title)
					.foregroundColor(.accentColor)
			
		}
		.modifier(RowModifier())
	}
}


struct CheckAmountRow_Previews: PreviewProvider {
	static var previews: some View {
		CheckAmountRow(checkAmount: .constant(""))
	}
}
