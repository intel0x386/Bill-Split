//
//  BillRecords.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import Foundation

struct BillRecord: Identifiable {
	var persons: Int
	var tipPercent: Int
	var checkAmount: String
	var date: Date = Date()
	var id = UUID()
}

class BillRecords: ObservableObject, Identifiable {
	@Published var records: [BillRecord]
	
	init() {
		if let data = UserDefaults.standard.array(forKey: SymbolsAndConstants.key) as? [BillRecord] {
			records = data
		} else {
			records = []
		}
	}
	
	func storeRecord(record: BillRecord) {
		records.append(record)
	}
	
}
