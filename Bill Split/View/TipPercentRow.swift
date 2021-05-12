//
//  TipPercentRow.swift
//  Bill Split
//
//  Created by Ankit Shah on 5/11/21.
//

import SwiftUI

struct TipPercentRow: View {
	
	@Binding var tipPercent: Int
	
	var body: some View {
		Group {
			HStack {
				Text("Tip Percentage")
					.kerning(1)
					.font(.body)
				Spacer()
				
				Menu {
					Picker("Tip Percentage", selection: $tipPercent) {
						ForEach (0..<101) { num in
							Text("\(num) %")
						}
					}
				} label: {
					NumberBox(text: "\(tipPercent)", frameWidth: 80)
				}

				Stepper("Tip Percentage", value: $tipPercent, in: 0...100, step: 5)
					
					.labelsHidden()
				
			}
			.modifier(RowModifier())
		}
	}
}

struct TipPercentRow_Previews: PreviewProvider {
    static var previews: some View {
			TipPercentRow(tipPercent: .constant(25))
    }
}
