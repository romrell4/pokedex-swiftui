//
//  PokemonDetailRow.swift
//  Pokemon WatchKit Extension
//
//  Created by Eric Romrell on 6/25/21.
//

import SwiftUI

struct PokemonDetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label).bold()
            Spacer()
            Text(value)
        }
        .padding()
        .font(.caption)
    }
}

struct PokemonDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailRow(label: "Label", value: "Value")
    }
}
