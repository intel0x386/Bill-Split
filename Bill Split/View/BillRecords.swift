//
//  BillRecords.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import Foundation

struct BillRecord: Identifiable, Codable {
	var persons: Int
	var tipPercent: Int
	var checkAmount: String
	var date: Date = Date()
	var id = UUID()
	
	var amountPerPerson: String {
		get {
			let checkAmountDouble = Double(checkAmount) ?? 0
			let totalAmt: Double = checkAmountDouble + checkAmountDouble * Double(tipPercent) / 100
			let perPerson = totalAmt / Double((persons + 2))
			return String(format: "%.1f", perPerson)
		}
	}
	
}

extension BillRecord {
	init(record: BillRecord) {
		self.persons = record.persons
		self.tipPercent = record.tipPercent
		self.checkAmount = record.checkAmount
		self.date = record.date
	}
}

class BillRecords: ObservableObject, Identifiable {
	
//	static func == (lhs: BillRecords, rhs: BillRecords) -> Bool {
//		false
//	}
//	
//	func hash(into hasher: inout Hasher) {
//		hasher.combine(records)
//	}
	
	@Published var records: [BillRecord]
	
	init() {
		if let data = UserDefaults.standard.value(forKey: SymbolsAndConstants.key) as? Data {
			let jsonD = JSONDecoder()
			if let jsonData = try? jsonD.decode([BillRecord].self, from: data)
			{
				records = jsonData
				print("Fetched \(records.count) records from DB")
				for recs in records {
					print("\(recs.checkAmount)-\(recs.persons)")
				}
				return
			}
		}
		print("Found no records")
		records = []
	}
	
	func deleteRecord(indexSet: IndexSet) {
		if let indFirst = indexSet.first {
			records.remove(at: indFirst)
			saveRecords()
		}
	}
	
	func saveRecords() {
		let jsonE = JSONEncoder()
		if let data = try? jsonE.encode(records) {
			UserDefaults.standard.setValue(data, forKey: SymbolsAndConstants.key)
		}
	}
	
	func storeRecord(record: BillRecord) {
		records.append(BillRecord(record: record))
		print("Saving \(record.checkAmount)-\(record.persons)")
		saveRecords()
	}
}
