//
//  Symbols.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import Foundation
import SwiftUI

class SymbolsAndConstants {
	
	static let currencyUnit: String =
		{
			print("Currenty Unit Called")
			let formatter = NumberFormatter()
			formatter.numberStyle = .currency
			return formatter.locale.currencySymbol ?? ""
		}()
	
	static let key = "BillRecordsKey"
}

extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
