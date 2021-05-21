//
//  BillDetails.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/21/21.
//

import SwiftUI

struct BillDetails: View {
	var record: BillRecord
	var body: some View {
		Form {
			Section(header: Text("Location:")) {
				Text("Map View - coming soon")
			}
			Section(header: Text("Bill Details:")) {
				List {
					DetailViewRow(leftS: "Check Amount", rightS: "\(record.checkAmount) \(SymbolsAndConstants.currencyUnit)")
					DetailViewRow(leftS: "Number of People", rightS: "\(record.persons) ")
					DetailViewRow(leftS: "Tip Percentage", rightS: "\(record.tipPercent)% ")
					
				}
			}
		}
	}
}

struct DetailViewRow: View {
	var leftS: String
	var rightS: String
	var body: some View {
		HStack {
			DetailViewRowText(title: leftS)
			Spacer()
			DetailViewRowText(title: rightS)
		}
	}
}


struct DetailViewRowText: View {
	var title: String
	
	var body: some View {
		Text(title)
			.kerning(1)
			.font(.body)
	}
}

struct BillDetails_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			BillDetails(record: BillRecord(persons: 10, tipPercent: 25, checkAmount: "5000"))
		}
	}
}

