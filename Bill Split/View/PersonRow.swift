//
//  PeopleRow.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI

struct PersonRow: View {
	
	@Binding var persons: Int
	
	var body: some View {
		Group {
			HStack {
				PeopleRowText()
				Spacer()
				Menu(content: {
					Picker("Number of People", selection: $persons) {
						ForEach (2..<51) { num in
							Text("\(num) People")
						}
					}
				}, label: {
					NumberBox(text: "\(persons + 2)")
				})
				Stepper("Num Of People", value: $persons, in: 0...48)
					.labelsHidden()
			}
			.modifier(RowModifier())
		}
	}
}

struct PeopleRowText: View {
	var body: some View {
		Group {
			Text("Number of People")
				.kerning(1)
				.font(.body)
		}
	}
}

struct NumberBox: View {
	
	var text: String
	var frameWidth: CGFloat = 80
	
	var body: some View {
		Text(text)
			.font(.title)
			.kerning(2)
			.padding(.horizontal, 10)
			.padding(.vertical, 5)
			.frame(width: frameWidth)
			.overlay(
				RoundedRectangle(cornerRadius: 6)
					.strokeBorder(Color.accentColor, lineWidth: 3)
			)
	}
}


struct RowModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background(Color("rowBackgroundColor"))
			.cornerRadius(20)
	}
}



struct PeopleRow_Previews: PreviewProvider {
    static var previews: some View {
			PersonRow(persons: .constant(10))
    }
}

